class Item < ActiveRecord::Base
  validates_presence_of :en_headline
  validates_presence_of :en_leadtext
  validates_presence_of :en_content
  validates_presence_of :de_headline
  validates_presence_of :de_leadtext
  validates_presence_of :de_content

  def translate(language)
    { :headline => self.send((language+"_headline").to_sym),
      :leadtext => self.send((language+"_leadtext").to_sym),
      :content => self.send((language+"_content").to_sym),
      :id => self.id
    }
  end
end
