FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "john#{i}" }
    email { "#{username}@example.com" }
    password { "strong_password" }
  end
end

# USAGE
# # Returns a User instance that's not saved
# user = build(:user)
#
# # Returns a saved User instance
# user = create(:user)
#
# # Returns a hash of attributes that can be used to build a User instance
# attrs = attributes_for(:user)
#
# # Returns an object with all defined attributes stubbed out
# stub = build_stubbed(:user)
#
# # Passing a block to any of the methods above will yield the return object
# create(:user) do |user|
#   user.posts.create(attributes_for(:post))
# end

# # Build a User instance and override the first_name property
# user = build(:user, first_name: "Joe")
# user.first_name
# # => "Joe"

# Associations
#
# Implicit definition
# It's possible to set up associations within factories. If the factory name is the same as the association name, the factory name can be left out.
#
# factory :post do
#   # ...
#   author
# end
# Explicit definition
# You can define associations explicitly. This can be handy especially when Overriding attributes
#
# factory :post do
#   # ...
#   association :author
# end
# Specifying the factory
# You can specify a different factory (although Aliases might also help you out here).
#
# Implicitly:
#
# factory :post do
#   # ...
#   author factory: :user
# end
# Explicitly:
#
# factory :post do
#   # ...
#   association :author, factory: :user
# end

# Nested factories
# You can easily create multiple factories for the same class without repeating common attributes by nesting factories:
#
# factory :post do
#   title { "A title" }
#
#   factory :approved_post do
#     approved { true }
#   end
# end
#
# approved_post = create(:approved_post)
# approved_post.title    # => "A title"
# approved_post.approved # => true
