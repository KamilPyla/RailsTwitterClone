FactoryBot.define do
  factory :reported_comment do
    content { "MyText" }
    micropost { nil }
  end
end
