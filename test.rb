#!/usr/bin/ruby

require 'rubygems'
require 'sinatra'

get '/random/integer' do
	(params[:min].to_i + rand(1+params[:max].to_i-params[:min].to_i)).to_s
end