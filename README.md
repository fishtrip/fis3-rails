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

目前提供了两个Helper：

1. fis3_asset_path(asset_nam) 根据资源名称去寻找对应的地址。
1. fis3_dep_asset_path(asset_nam) 对于js资源，fis可能也编译出来一个css文件，调用这个方法即可。

使用方法：

1. 在你的layout文件中添加yield，比如
在head标签中插入:

```ruby
<%= yield :header_scripts %>
```

在body标签最后插入：
```ruby
<%= yield :footer_scripts %>
```

1. 调用某个fis js 资源时:

```ruby
<%= javascript_include_tag fis3_asset_path('js/mobile/base') %>
<% content_for :header_scripts do %>
  <%= stylesheet_link_tag fis3_dep_asset_path('js/mobile/base') %>
<% end %>
```

1. 调用某个fis css 资源时:

```ruby
<%= stylesheet_link_tag fis3_asset_path('css/mobile/base') %>
```


## Development

TODO.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fishtrip/fis3-rails.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

