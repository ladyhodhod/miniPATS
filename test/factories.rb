# Factory Bot (previously known as Factory Girl) is a library gem specific to Ruby.
  # https://github.com/thoughtbot/factory_bot
# Factory Bot creates test fixtures that are fake test objects that can be re-used throughout testing an application.
# Read more about FactoryBot:
# https://medium.com/@mariacristina.simoes/my-introduction-to-factory-bot-88949467a7e9

FactoryBot.define do


  # a factory defines a blueprint of how to create objects of a certain model/classs
  factory :animal do
      # so any animal created using the factoryBot will have the name 'Cat' and active true, by default
    name "Cat"
    active true
  end

  factory :owner do
    first_name "Alex"
    last_name "Heimann"
    street "10152 Sudberry Drive"
    city "Wexford"
    state "PA"
    zip "15090"
    active true
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
  end
  
  factory :pet do
    name "Dusty"
    female true
    active true
    dob 10.years.ago
    association :owner  # we don't have to put the word association in front, but I think it helps...
    association :animal
  end
  
  factory :visit do
    association :pet 
    date 6.months.ago.to_date
    weight 5.0
    overnight_stay false
    total_charge 5000
  end

end