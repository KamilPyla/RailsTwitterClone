FactoryBot.define do
  factory :reported_comment do
    contend { "MyText" }
    micropost { nil }
  end
end
