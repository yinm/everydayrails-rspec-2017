FactoryGirl.define do
  factory :user do
    first_name "Aaron"
    last_name "Sumner"
    sequence(:email) { |n| "tester#{n}@example.cm" }
    password "dottle-nouveau-pavilion-tights-furze"
  end
end
