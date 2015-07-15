# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_call do
    to "MyString"
    from "MyString"
    duration "MyString"
    access_code "MyString"
    result "MyString"
  end
end
