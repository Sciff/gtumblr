FactoryGirl.define do
  factory :location do
    title Faker::Address.city
    address Faker::Address.street_name
    latitude 1.5
    longitude 1.5
    user
  end

end
