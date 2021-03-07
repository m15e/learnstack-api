class FavoritesRepresenter
  def initialize(favorites)
    @favorites = favorites
  end

  def as_json
    favorites.map(&:favorited_id)
  end

  private

  attr_reader :favorites
end
