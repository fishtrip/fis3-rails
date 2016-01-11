# Fis3::Rails

帮助更好的集成 F.I.S (fis.baidu.com) 前端开发框架和Rails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fis3-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fis3-rails

## Usage

目前提供了三个Helper：

1. 调用某个fis js 资源时:

```ruby
<%= fis3_javascript_tag('js/mobile/base') %>
```

1. 调用某个fis css 资源时:

```ruby
<%= fis3_stylesheet_tag('css/mobile/base') %>
```

1. 因为fis中的js文件也可能导致css产生，所以使用js时也需要同时调用:

```ruby
<%= fis3_stylesheet_tag_by_js('js/mobile/base') %>
```


## Development

TODO.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fishtrip/fis3-rails.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

