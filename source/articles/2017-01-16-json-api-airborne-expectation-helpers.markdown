---
title: JSON API Helpers for API Testing in Rails using Airborne
date: 2017-01-16
layout: post
tags: api, rails
---
I am a huge fan of the [Airborne](https://github.com/brooklynDev/airborne) gem for testing APIs. Airborne uses `rest_client` to make HTTP requests and provides the following properties for use in your tests.

- `response` - The HTTP response returned from the request
- `headers` - A symbolized hash of the response headers returned by the request
- `body` - The raw HTTP body returned from the request
- `json_body` - A symbolized hash representation of the JSON returned by the request

It also provides some nice expectation helpers. A simple Airborne request spec looks like this...

```ruby
describe 'sample spec' do
  it 'should validate types' do
    get 'http://example.com/api/v1/simple_get' #json api that returns { "name" : "John Doe" }
    expect_json_types(name: :string)
  end

  it 'should validate values' do
    get 'http://example.com/api/v1/simple_get' #json api that returns { "name" : "John Doe" }
    expect_json(name: 'John Doe')
  end
end
```

The built-in matchers are nice, but they left me wanting when I was working on an API conforming to the [JSON API](http://jsonapi.org/) spec. I came up with he following matchers as a much easier way to test the API and ensure it conformed to the JSON API spec.

<script src="https://gist.github.com/Ross-Hunter/5619d8f4e5bf21a59d51805eba7334f9.js"></script>

Using these helpers a request spec might look something like this.

```ruby
describe 'widgets' do
    let(:user) { create :user }
    let(:widget_attributes) { { name: 'foo' } }
    let(:widget_relations) { { 'organization' => { data: { id: organization.id } } } }

    before :example do
        authenticate user
    end

    example 'creating a widget' do
      authed_post widgets_path, attributes: widget_attributes,
                                relationships: widget_relations
      expect_status :ok
      expect_attributes name: widget_attributes[:name]
      expect_relationship key: 'organization', 
                          link: organization_path(organization.id)
    end
end
```

You might notice that also uses an `authed_post` helper, which is from another set of helpers I created for making token-auth requests easier and JSON API compliant.

<script src="https://gist.github.com/Ross-Hunter/85efd826f038fd81910e800834c3d323.js"></script>

I'm thinking about packaging up these helpers as a gem, but they might be best served as just public gists for you to fork and modify for your own needs.
