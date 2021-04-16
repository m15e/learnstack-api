class FavoriteRepresenter
  def initialize(favorite)
    @favorite = favorite
  end

  def as_json
    {
      id: favorite.id,
      user_id: favorite.user_id,
      stack_id: favorite.stack_id
    }
  end

  private

  attr_accessor :favorite
end
