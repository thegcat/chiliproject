# redMine - project management software
# Copyright (C) 2006-2007  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class WatchersController < ApplicationController
  before_filter :find_project
  before_filter :require_login, :check_project_privacy, :only => [:watch, :unwatch]
  before_filter :authorize, :only => [:new, :destroy, :create]
  
  verify :method => :post,
         :only => [ :watch, :unwatch, :create, :destroy ],
         :render => { :nothing => true, :status => :method_not_allowed }
  
  def watch
    if @watched.respond_to?(:visible?) && !@watched.visible?(User.current)
      render_403
    else
      set_watcher(User.current, true)
    end
  end
  
  def unwatch
    set_watcher(User.current, false)
  end
  
  def new
    respond_to do |format|
      format.html { redirect_to :back }
      format.js do
        render :update do |page|
          page.replace_html 'watchers', :partial => 'watchers/watchers', :locals => {:watched => @watched, :render_watcher_dropdown => true}
        end
      end
    end
  end
  
  def create
    set_watcher(User.find(params[:watcher][:user_id]), true, :render_watcher_dropdown => true)
  end
  
  def destroy
    set_watcher(User.find(params[:user_id]), false)
  end
  
private
  def find_project
    klass = Object.const_get(params[:object_type].camelcase)
    return false unless klass.respond_to?('watched_by')
    @watched = klass.find(params[:object_id])
    @project = @watched.project
  rescue
    render_404
  end
  
  def set_watcher(user, watching, options={})
    @watched.set_watcher(user, watching)
    render_with_replace_selectors(options)
  end

  def render_with_replace_selectors(options={})
    respond_to do |format|
      format.html { redirect_to :back }
      format.js do
        options[:replace_selectors] = if params[:replace].present?
          if params[:replace].is_a? Array
            params[:replace]
          else
            params[:replace].split(',').map(&:strip)
          end
        else
          ['#watcher']
        end
        
        @options = options

        render :action => 'replace_selectors'
      end
    end
  rescue ::ActionController::RedirectBackError
    render :text => (watching ? 'Watcher added.' : 'Watcher removed.'), :layout => true
  end
end
