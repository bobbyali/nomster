FactoryGirl.define do
  
  factory :user do    
    sequence :email do |n|
      "random#{n}@nomster.com"
    end
    password "omglolhahaha"
    password_confirmation "omglolhahaha"
  end


end
