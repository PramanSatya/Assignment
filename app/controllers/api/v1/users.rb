=begin
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
=end
module API
  module V1
    class Users < Grape::API
      version 'v1', using: :path
      format :json
      formatter :json, Grape::Formatter::Roar
      prefix :api

      helpers do
        def token
          request.headers['Auth-Token']
        end

        def current_user
          User.find_by(token: token)
        end
      end

      namespace :users do
        desc 'Login'
        post '/login' do
          user = User.find_by(email: params[:email])
          return {errors: "Invalid email"} if user.nil?
          if user.password == params[:password]
            present user.token
          end
        end
        get '/' do
          return {}
        end

        desc 'update'
        put '/update' do
          user = current_user
          return {error: "wrong token given"} if user.nil?
          temp = ActionController::Parameters.new(params)
          temp = temp.permit(:first_name, :last_name, :phone_number)
          user.assign_attributes(temp)
          user.save
          present user, with: UserRepresenter
        end
      end
    end
  end
end
