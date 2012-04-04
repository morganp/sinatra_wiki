class Page < ActiveRecord::Base
  
  def name
    self.url
  end

  def markdown
    self.body
  end
  
  def html
    Maruku.new(markdown).to_html.gsub(/\[\[(\w+)\]\]/,'<a href="\1">\1</a>').gsub(/([A-Z]+)([a-z]+)([A-Z]+)\w+/,'<a href="\0">\0</a>')
  end
  
  def content= txt
    self.body = txt
    self.save
  end


end

