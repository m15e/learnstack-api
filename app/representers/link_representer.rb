class LinkRepresenter
  def initialize(link)
    @link = link
    
  end

  def as_json    
    {
      id: link.id,
      title: link.title,
      url: link.url,
      tags: link.tags,
      medium: link.medium,
      stack_id: link.stack_id
    }    
  end

  private

  attr_accessor :link
end