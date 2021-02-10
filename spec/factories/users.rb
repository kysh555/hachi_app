FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 6)}
    email {Faker::Internet.email}
    password {Faker.Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end