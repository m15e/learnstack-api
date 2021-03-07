class FavoriteRepresenter
  def initialize(favorite)
    @favorite = favorite
  end

  def as_json
    {
      id: favorite.id,
      user: favorite.user_id,
      favorite_stack: favorite.favorited_id
    }
  end

  private

  attr_accessor :favorite
end
