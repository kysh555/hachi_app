FactoryBot.define do
  factory :work do
    title {Faker::Name.name}
    description {Faker::Lorem.sentences}

    association :user

    after(:build) do |work|
      work.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end