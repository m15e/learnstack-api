class FavoritesRepresenter
  def initialize(favorites)
    @favorites = favorites
  end

  def as_json
    favorites.map do |favorite|      
       favorite.favorited_id         
    end
  end

  private

  attr_reader :favorites
end
