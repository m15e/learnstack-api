class StacksRepresenter
  def initialize(stacks)
    @stacks = stacks
  end

  def as_json
    stacks.map do |stack|
      {
        id: stack.id,
        title: stack.title,
        links: stack.links
      }
    end
  end

  private

  attr_reader :stacks
end