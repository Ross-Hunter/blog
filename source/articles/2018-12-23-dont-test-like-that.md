---
title: Don't Test Like That!
date: 2018-12-23
layout: post
tags: testing, code, rails, javascript
cover: test.jpg
id: 21
---
As a consultant, I come across a lot of bad test suites in Rails and JavaScript apps. The following are all RSpec, Jest, or Jasmine tests that I have found in the wild -- with minor changes for clarity or to protect the guilty :) (myself included!)

These are some simple things *not to do*, along with some advice about what *to do* to accomplish the same goal.

###Don't test internals in a system test

System tests should be (mostly) <a href="http://softwaretestingfundamentals.com/black-box-testing/" target="_blank">black box</a>.

__*Don't do this*__

```ruby
# RSpec
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
- What if you refactor so that product no longer delegates to inventory? Your system test knows too much about the internals!

__*Do something like this*__

```ruby
# RSpec
RSpec.describe 'Product Display Page' do
  let(:product) { FactoryBot.create :product }
  let(:inventory_message){ 'Going Quick!' }

  it 'displays the inventory messaging' do
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

I both love and hate when framework scaffolding creates unit tests for you. More than once I have opened up an app and gone straight to the tests, scanned them and thought "OK, pretty good test coverage", only to discover later that I had randomly checked the handful of tests with actual content, meanwhile dozens of files are basically empty.

__*Don't do this*__

```javascript
// Jest
describe("AppCodes", function() {
  it("contains spec with an expectation", function() {
    expect(true).toBe(true);
  });
});
```
- You trick people into thinking your app has tests!

__*Do something like this*__

```javascript
// Jest
describe("AppCodes", function() {
  it("can instantiate a new instance without exploding", function() {
    new AppCode;
  });
});
```
- I will usually write tests like these as a bare minimum test to get started and ensure all of my test and app files are being loaded correctly. I try to never commit a blank (or commented out) test.
- I use this as a starting point, and add tests that actually test behavior, and I'll go back and remove these redundant tests that just add weight to the application.

###Don't unit test constants

Unit testing that language features like constants work is a waste of time. They take time and get in the way of actual tests.

__*Don't do this*__

```ruby
# RSpec
RSpec.describe "REBOOT_UNIT" do
  it "is the value the unit understands as reboot" do
    expect(RemoteUnit::REBOOT_UNIT).to eql('reboot')
  end
end
```
- One of the reasons to use a named constant is to not worry about what the actual value of it is.

__*Do something like this*__

```ruby
# RSpec
RSpec.describe "REBOOT_UNIT" do
  it "publishes a message to reboot the unit" do
    remote_unit.reboot_unit
    expect(messenger).to have_received(:publish)
      .with({type: RemoteUnit::REBOOT_UNIT})
  end
end
```
- This tests actual behavior, and ensures that the constant is being properly used, without caring about its value.

###Don't unit test variable assignment

I've also seen variable assignment tests like this too many times. Test this through some sort of behavior test, this is not a good unit test.

__*Don't do this*__

```ruby
#RSpec
RSpec.describe Chemical do
  RSpec.describe 'water' do
    before do
      @water = Chemical.water
    end

    it 'should return water' do
      Chemical.water.should == @water
    end
  end
end
```
- `Cemical.water` should equal `Chemical.water`? Really? You actually wrote a test like that?

__*Do something like this*__

```ruby
#RSpec
RSpec.describe Chemical do
  RSpec.describe 'water' do
    it 'is a chemical' do
      expect(Chemical.water).to be_a(Chemical)
    end
  end
end
```
- You are on your way to actually describing the behavior now! Keep going, tell us more about what it means that `Chemical.water` is a Chemical!

###Don't repeat yourself

We must walk a fine line in our tests, where we keep them very plain and readable, so that we don't get lost in the complexity of the test themselves. However, we can still follow best practices and use variables to clean up tests and make them easier to read and write.

__*Don't do this*__

```javascript
// jest + enzyme
describe('Criteria Selector', () => {
  it('shows the selection criteria', () => {
    const wrapper = mount(<CriteriaPicker criteria={ 
      startDate: '2018-05-05',
      endDate: '2018-05-10'
    } />);
    expect(wrapper.find('#startDate').props().value).toEqual('2018-05-05');
    expect(wrapper.find('#endDate').props().value).toEqual('2018-05-10');
  });
});
```
- This code is not very re-usable. You will need to update the date in multiple places if you ever want to change it.

__*Do something like this*__

```javascript
// jest + enzyme
describe('Criteria Selector', () => {
  it('shows the selection criteria', () => {
    let selectionCriteria = { 
      startDate: '2018-05-05',
      endDate: '2018-05-10'
    }
    const wrapper = mount(<CriteriaPicker criteria={selectionCriteria} />);
    expect(wrapper.find('#startDate').props().value).toEqual(selectionCriteria.startDate);
    expect(wrapper.find('#endDate').props().value).toEqual(selectionCriteria.endDate);
  });
});
```

- We use a variable to represent our input, and then we test that the new output is equal to our input.

###Don't test the absensce of an error

Do not allow the absence of an error, or the presence of a success message to be your indicator of success. Test the actual result!

__*Don't do this*__

```ruby
#RSpec
Rspec.describe 'Admin Settings Page' do
  it 'can update settings' do
    visit general_settings_path

    fill_in 'settings[conversion_rate]', with: 0.75
    click_button 'update'

    expect(page).to have_content('Settings have been saved.')
  end
end
```

__*Do something like this*__

```ruby
#RSpec
Rspec.describe 'Admin Settings Page' do
  it 'can update settings' do
    conversion_rate = '0.75'
    visit general_settings_path

    fill_in 'settings[conversion]', with: conversion_rate
    click_button 'update'

    # It's fine to test this message, but it's not a real indication that it worked how you expected
    expect(page).to have_content('Settings have been saved.')

    visit general_settings_path
    expect(page).to have_content(conversion_rate)
  end
end
```

- Success messages are great for your user, but they do not actually prove that your operation succeeded. Perhaps it was a 200 OK, but didn't actually do the thing you intended!

###Conclusion

The theme here is to actually think about what you are testing and not just write tests because you were told that is what the cool kids are doing. Bad tests can actually get in the way and create rigidity around your code in a way you don't intend. 

Even worse, when you write tests like this you might come to the conclusion that "testing sucks and is just a waste of time". Testing is awesome and possibly the single biggest "upgrade" you can apply to your software development skills.

###To the listener

What are some common mistakes you see made in tests? There were a lot of "smelly" tests that almost made the cut for this post and perhaps I'll do a part 2 at some point. 
