#! /usr/bin/env ruby

require 'cgi'
require 'net/http'
require 'rubygems'
require 'json'

module GTranslate
  def detect(text)
    base = 'http://ajax.googleapis.com/ajax/services/language/detect'
    params = {
      :q => text,
      :v => 1.0
    }
    query = params.map{ |k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')

    response = Net::HTTP.get_response( URI.parse( "#{base}?#{query}" ) )
      json = JSON.parse(response.body)

    if json['responseStatus'] == 200
      json['responseData']['language']
    else
      raise StandardError, response['responseDetails']
    end
  end

  def translate( text, to, from = nil)
    if from.nil? then
      from = GTranslate.detect(text)
    end

    base = 'http://ajax.googleapis.com/ajax/services/language/translate'
    params = {
      :langpair => "#{from}|#{to}",
      :q => text,
      :v => 1.0
    }

    query = params.map{ |k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')

    response = Net::HTTP.get_response( URI.parse( "#{base}?#{query}" ) )
      json = JSON.parse( response.body )

    if json['responseStatus'] == 200
      json['responseData']['translatedText']
    else
      raise StandardError, response['responseDetails']
    end

  end

  def tag(title, space = " ", lang = nil)
    GTranslate.translate(title, 'en', lang).downcase.strip.gsub(/[^a-z\d\s]/, '').gsub(/\s+/, space.to_s)
  end

  module_function :detect, :translate, :tag
end

