FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    favorited_type { "Stack" }
    favorited_id { 1 }
  end
end
