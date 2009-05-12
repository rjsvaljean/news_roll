# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsRollExtension < Radiant::Extension
  version "0.1"
  description "A Radiant extension to add and manage news items in German and English"
  url "http://rxvl.wordpress.com"
  
  define_routes do |map|
    map.news 'news', :controller => 'news', :action => 'index'
    map.news 'news/show/:id', :controller => 'news', :action => 'show'
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :items
    end
  end
  
  def activate
    admin.tabs.add "News Roll", "/admin/items", :after => "Layouts", :visibility => [:all]
    Page.send :include, NewsRollTags
    SiteController.class_eval{
      session :disabled => false
    }

  end

  def deactivate
    # admin.tabs.remove "News Roll"
  end

end
