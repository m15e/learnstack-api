class StacksRepresenter
  def initialize(stacks)
    @stacks = stacks
  end

  def as_json
    stacks.map do |stack|
      {
        id: stack.id,
        title: stack.title,        
        tags: stack.tags,
        links: stack.links,
        user_id: stack.user_id,
      }
    end
  end

  private

  attr_reader :stacks
end