class favoriteRepresenter
  def initialize(favorites)
    @favorites = favorites
  end

  def as_json
    favorites.map do |stack|
      {
        id: favorite.id,
        user: favorite.user_id,
        favorite_stack: favorite.favorited_id   
      }
    end
  end

  private

  attr_reader :favorite
end