FactoryBot.define do
  factory :user do
    name { "Exaple" }
    email {'example@user.com'}
    password {'password'}
    password_confirmation {'password'}
    gender {'m'}
    
  end
end
