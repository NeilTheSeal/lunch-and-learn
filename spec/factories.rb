require "faker"

FactoryBot.define do
  factory :whatever do
    property { Faker::Number.between(from: 0, to: 20) }
  end
end
