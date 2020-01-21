require "faker"
require_relative "../models/user_model"

FactoryBot.define do
  factory :user, class: UserModel do
    full_name { "Victor dos Santos" }
    email { "vy.santos@live.com" }
    password { "123456" }

    after(:build) do |user|
      Database.new.delete_user(user.email)
    end
  end

  factory :user_wrong_email, class: UserModel do
    full_name { "Victor dos Santos" }
    email { "vy.santos$live.com" }
    password { "123456" }
  end

  factory :empty_name_user, class: UserModel do
    full_name { "" }
    email { "vy.santos@live.com" }
    password { "123456" }
  end

  factory :empty_email_user, class: UserModel do
    full_name { "Victor dos Santos" }
    email { "" }
    password { "123456" }
  end

  factory :empty_password_user, class: UserModel do
    full_name { "Victor dos Santos" }
    email { "vy.santos@live.com" }
    password { "" }
  end

  factory :registered_user, class: UserModel do
    id { 0 }
    full_name { Faker::Movies::HarryPotter.character }
    email { Faker::Internet.free_email(name: full_name) }
    password { "darthvader" }

    after (:build) do |user|
      #puts "apagando o email" + user.email
      Database.new.delete_user(user.email)
      result = ApiUser.save(user.to_hash)
      user.id = result.parsed_response["id"]
    end
  end

  #IMPLEMENTAÇÃO DE VALIDAÇÃO DOS CAMPOS NULOS

  factory :null_username, class: UserModel do
    email { "anaki@jedi.com" }
    password { "123456" }
  end

  factory :null_useremail, class: UserModel do
    full_name { "Anakin Skywalker" }
    password { "123456" }
  end

  factory :null_userpassword, class: UserModel do
    full_name { "Anakin Skywalker" }
    email { "anaki@jedi.com" }
  end
end
