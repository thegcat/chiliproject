#-- copyright
# ChiliProject is a project management system.
# 
# Copyright (C) 2010-2011 the ChiliProject Team
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# See doc/COPYRIGHT.rdoc for more details.
#++

# This file was generated by the "jdbc" generator, which is provided
# by the activerecord-jdbc-adapter gem.
#
# This file allows you to use Rails' various db:* tasks with JDBC.
if defined?(JRUBY_VERSION)
  require 'jdbc_adapter'
  require 'jdbc_adapter/rake_tasks'
end
