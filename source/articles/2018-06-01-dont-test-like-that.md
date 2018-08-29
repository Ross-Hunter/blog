---
title: Don't Test Like That!
date: 2018-06-01
layout: post
tags: testing, code, rails, javascript
cover: test.jpg
published: false
id: 21
---
As a consultant, I come across a lot of bad test suites in Rails and JavaScript apps. The following are all either RSpec, Jest, or Jasmine tests that I have found in the wild (with minor changes for clarity). A few of them are even my fault!

These are some simple things *not to do*, along with some advice about what *to do* to accomplish the same goal.

###Don't test internals in a system test

__*Don't do this*__

```ruby
RSpec.describe 'Product Display Page' do
  it 'displays the inventory messaging' do
    product = FactoryBot.create :product
    FactoryBot.create :inventory, product: product, 
                                  inventory_message: 'Going Quick!'
    visit product_path(product)
    # product delegates :inventory_message to :inventory
    expect(page).to have_content(product.inventory_message)
  end
end
```
- What if `product.inventory_message` is not being properly delegated and is nil or empty? Your tests pass!
- What if you refactor so that product no longer delegates to inventory? Your system test knows too much about the internals! System tests should be (mostly) a <a href="http://softwaretestingfundamentals.com/black-box-testing/" target="_blank">black box</a>.

__*Do this*__

```ruby
RSpec.describe 'Product Display Page' do
  it 'displays the inventory messaging' do
    inventory_message = 'Going Quick!'
    product = FactoryBot.create :product
    FactoryBot.create :inventory, product: product, 
                                  inventory_message: inventory_message
    visit product_path(product)
    expect(page).to have_content(inventory_message)
  end
end
```
- You don't have information buried in the parameters to a method
- The test will pass if the content appears on the page, and fail if the content does not appear on the page, regardless of what internals might change.

###Don't write blank tests

I both love and hate when framework scaffolding creates unit tests for you. More than once I have opened up a Rails app and gone straight to the tests, scanned them and thought "OK, pretty good test coverage", only to discover later that I had randomly checked the handful of tests with actual content, meanwhile dozens of files are basically empty.

__*Don't do this*__

```javascript
describe("AppCodes", function() {
  it("contains spec with an expectation", function() {
    expect(true).toBe(true);
  });
});
```
- You trick people into thinking your app has tests!

__*Do this*__

```javascript
describe("AppCodes", function() {
  it("can instantiate a new instance", function() {
    new AppCode;
  });
});
```
- I will usually write tests like these as a bare minimum test to get started and ensure all of my test and app files are being loaded correctly. I try to never commit a blank (or commented out) test.

###Don't unit test constants

Unit testing that language features work is a waste of time. They get in the way of actual tests.

__*Don't do this*__

```ruby
RSpec.describe "REBOOT_UNIT" do
  it "is the value the unit understands as reboot" do
    expect(RemoteUnit::REBOOT_UNIT).to eql('reboot')
  end
end
```
- One of the reasons to use a constant like this is to not worry about what the actual value of the constant is.

__*Do this*__

```ruby
RSpec.describe "REBOOT_UNIT" do
  it "publishes a message to reboot the unit" do
    remote_unit.reboot_unit
    expect(messenger).to have_received(:publish)
      .with({type: RemoteUnit::REBOOT_UNIT})
  end
end
```
- This tests actual behavior, and ensures that the constant is being properly used, without caring about its value.

###Don't repeat yourself

__*Don't do this*__

```javascript
// jest
describe('Criteria Selector', () => {
  it('shows the selection criteria', () => {
    let selectionCriteria = { 
      startDate: '2018-05-05',
      endDate: '2018-05-10'
    }
    //const wrapper = mount(<CriteriaPicker criteria={selectionCriteria} />);
    expect(wrapper.find('#startDate').props().value).toEqual('2018-05-05');
    expect(wrapper.find('#endDate').props().value).toEqual('2018-05-10');
  });
});
```
- This code is not very re-usable. You will need to update the date in multiple places if you want to change it.

__*Do this*__

```javascript
// jest
describe('Criteria Selector', () => {
  it('shows the selection criteria', () => {
    let selectionCriteria = { 
      startDate: '2018-05-05',
      endDate: '2018-05-10'
    }
    //const wrapper = mount(<CriteriaPicker criteria={selectionCriteria} />);
    expect(wrapper.find('#startDate').props().value).toEqual(selectionCriteria.startDate);
    expect(wrapper.find('#endDate').props().value).toEqual(selectionCriteria.endDate);
  });
});
```

###Don't unit test the framework

__*Don't do this*__

```ruby
RSpec.describe Chemical do
  before do
    @water = Chemical.water
  end

  RSpec.describe 'water' do
    it 'should return water' do
      Chemical.water.should == @water
    end
  end
end
```
- `Cemical.water` should equal `Chemical.water`? Really?

__*Do this*__

```ruby
RSpec.describe Chemical do
  RSpec.describe 'water' do
    it 'should return water as a chemical' do
      expect(Chemical.water).to be_a(Chemical)
    end
  end
end
```
- You are actually describing the behavior now! Keep going, tell us more about what `Chemical.water` does!

# Maybe cut it off right here

###Don't write clever tests

"Don't repeat yourself" can be taken too far and we can end up creating too much complexity in our tests. 

__*Don't do this*__

```ruby
class String
  def first_part
    regex = /[@ ]/
    self[regex] ? self.split(regex).first :
      self[0, ((self.size / 2.to_f).ceil + 1)]
  end
end

def search(user, profile, query)
  query = query.(profile) unless query.is_a?(String)
  ContactProfile.search_records(query, user)
end

RSpec.describe 'ContactProfile.search' do
  before do
    @user_a = create(:user)
    @user_b = create(:user)
    @profile_a = create(:contact_profile, user: @user_a)
    @profile_b = create(:contact_profile, user: @user_b)
  end

  [['by the first part of their email',
    ->(m) { m.email.split('@').first }],
   ['by their exact first name',
     ->(m) { m.first_name }],
   ['by first part of their full name',
    ->(m) { m.full_name.first_part }]].each do |(desc, query_fn)|
    describe desc do
      it 'matches user a to profile a' do
        results = search(@user_a, @profile_a, query_fn)
        expect(results.count).to eq(1)
      end

      it 'matches user b to profile b' do
        results = search(@user_b, @profile_b, query_fn)
        expect(results.count).to eq(1)
      end

      it 'does not match user a to profile b' do
        results = search(@user_a, @profile_b, query_fn)
        expect(results.count).to eq(0)
      end

      it 'does not match user b to profile a' do
        results = search(@user_b, @profile_a, query_fn)
        expect(results.count).to eq(0)
      end
    end
  end
end
```
- This tests the code we have written right here, not the code our app will run

__*Do this*__

```ruby
```


What are some common mistakes you see made in tests?
