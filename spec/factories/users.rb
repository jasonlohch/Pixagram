FactoryGirl.define do
  factory :user do
    name "Jon"
    email "jon@mail.com"
    password "123456"
    password_confirmation "123456"
  end

  factory :user1 do
    name "Kevin"
    email "kevin@mail.com"
    password "123456"
    password_confirmation "123456"
  end
end