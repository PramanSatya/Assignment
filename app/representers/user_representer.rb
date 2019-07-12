module UserRepresenter
  include Roar::JSON
  include Roar::Hypermedia
  include Grape::Roar::Representer

  property :email
  property :password
  property :first_name
  property :last_name
  property :phone_number
  property :id
  property :token
  property :created_at
  property :updated_at
end
