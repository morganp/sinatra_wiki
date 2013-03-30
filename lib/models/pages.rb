class Page < ActiveRecord::Base
  
  def name
    self.url
  end

  def markdown
    self.body
  end
  
  def html
    return Maruku.new(markdown).to_html
  end
  
  def content= txt
    self.body = txt
    self.save
  end


end

