# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'numgeon'
  app.frameworks += ["SpriteKit"]
  app.files_dependencies 'app/numgeon/unit/body.rb'   => 'app/numgeon/unit/base.rb'
  app.files_dependencies 'app/numgeon/unit/enemy.rb'  => 'app/numgeon/unit/base.rb'
  app.files_dependencies 'app/numgeon/unit/friend.rb' => 'app/numgeon/unit/base.rb'
  app.files_dependencies 'app/numgeon/unit/tile.rb'   => 'app/numgeon/unit/base.rb'
end
