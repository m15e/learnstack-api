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
        upvotes: stack.upvotes,
        downvotes: stack.downvotes,
      }
    end
  end

  private

  attr_reader :stacks
end