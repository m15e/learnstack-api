class StackRepresenter
  def initialize(stack)
    @stack = stack    
  end

  def as_json    
    {
      id: stack.id,
      title: stack.title,
      tags: stack.tags,
      links: stack.links,
      upvotes: stack.upvotes,
      downvotes: stack.downvotes,
      user_id: stack.user_id,
    }    
  end

  private

  attr_accessor :stack
end