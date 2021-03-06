#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: "sqlite3", database: "barbershop.db" }

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true

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

	if c.save
		erb "We are waiting for you"
	else
		@c = c
		@error = c.errors.full_messages.first
		erb :visit
	end

end

get '/contact' do
	erb :contact
end

post '/contact' do
	@name = params[:name]
	@mail = params[:mail]
	@message = params[:message]
	# { client: { name: 'Joe', surname: 'Biden' } }

	Contact.create({name: @name, mail: @mail, message: @message})

	erb :contact
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/bookings' do
	@clients = Client.all
	erb :bookings
end

get '/clients/:id' do
	@client = Client.find(params[:id])
	erb :client
end