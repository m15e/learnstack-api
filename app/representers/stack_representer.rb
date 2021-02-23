class StackRepresenter
  def initialize(stack)
    @stack = stack
  end

  def as_json    
    {
      id: stack.id,
      title: stack.title,
      links: stack.links
    }    
  end

  private

  attr_reader :stack
end