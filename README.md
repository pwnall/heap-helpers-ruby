# Heap Helpers for Ruby

[![Build Status](https://travis-ci.org/pwnall/heap-helpers-ruby.svg?branch=master)](https://travis-ci.org/pwnall/heap-helpers-ruby)
[![Coverage Status](https://coveralls.io/repos/github/pwnall/heap-helpers-ruby/badge.svg?branch=master)](https://coveralls.io/github/pwnall/heap-helpers-ruby?branch=master)
[![Dependency Status](https://gemnasium.com/pwnall/heap-helpers-ruby.svg)](https://gemnasium.com/pwnall/heap-helpers/ruby)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/pwnall/heap-helpers-ruby/master/frames)
[![Gem Version](https://badge.fury.io/rb/heap-helpers.svg)](https://badge.fury.io/rb/heap-helpers)

This Ruby gem contains helpers for embedding the
[heap.js snippet](https://heapanalytics.com/docs/installation#web) used to
instal [Heap](https://heapanalytics.com/) on a site.


## Prerequisites

This gem is tested on Ruby 1.8.7 and above, and is expected to work with Rails
2.3.8 and above. The gem depends on the official
[heap](https://github.com/heap/heap-ruby) gem.


## Installation

If you're using [bundler](http://bundler.io/), add the following line to your
[Gemfile](http://bundler.io/v1.11/gemfile.html).

```ruby
gem 'heap-helpers'
```

Otherwise, install the [heap-helpers](https://rubygems.org/gems/heap) gem and
activate it in your code manually.

```bash
gem install heap
```

```ruby
require 'heap-helpers'
```


## Setup

Follow the instructions for the `heap` gem.


## Usage

Add the following in your layouts or views, before the closing `</head>` tag.
In a typical Ruby on Rails application, this change would go into
`app/views/layouts/application.html.erb`.

```erb
<%= Heap.javascript_tag %>
```

The helper supports advanced heap.js options.

```erb
<%= Heap.javascript_tag force_ssl: true %>
```

You can also specify advanced options in the initialization code. This is
especially useful if you're using the same helper in multiple places in your
code.

```ruby
Heap.app_id = 'YOUR_APP_ID'
Heap.js_options = { force_ssl: true }
```


## Copyright

Copyright (c) 2016 Victor Costan, released under the MIT license.
