#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: "sqlite3", database: "barbershop.db" }

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end


before do 
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	# @username = params[:username]
	# @phone = params[:phone]
	# @datetime = params[:datetime]
	# @barber = params[:barber]
	# @color = params[:color]

	# Client.create({name: @username, phone: @phone, datestamp: @datetime, barber: @barber, color: @color})

	c = Client.new params[:client]
	c.save

	erb "good"

end

get '/contact' do
	erb :contact
end

post '/contact' do
	@name = params[:name]
	@mail = params[:mail]
	@message = params[:message]

	Contact.create({name: @name, mail: @mail, message: @message})

	erb :contact
end