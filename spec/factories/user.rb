FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { DEFAULT_PASSWORD }
    password_confirmation { DEFAULT_PASSWORD }
    state { User.states[:active] }

    factory :user_blocked do
      state { User.states[:blocked] }
    end

    factory :user_admin do
      state { User.states[:admin] }
    end
  end
end
