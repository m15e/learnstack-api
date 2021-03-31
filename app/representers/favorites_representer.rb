class FavoritesRepresenter
  def initialize(favorites)
    @favorites = favorites
  end

  def as_json
    #favorites.map(&:stack_id)
    favorites.map do |favorite|
      {
        id: favorite.id,
        user_id: favorite.user_id,
        stack_id: favorite.stack_id,
      }
    end
  end

  private

  attr_reader :favorites
end
