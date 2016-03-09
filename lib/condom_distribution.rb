require "condom_distribution/version"
require 'unirest'

module CondomDistribution
  class Condom

    attr_reader :venue_type, :address, :name


    def initialize(condom_api_info)
      @venue_type = condom_api_info["venue_type"]
      @address = condom_api_info["address"]
      @name = condom_api_info["name"]
    end

    def self.all
      api_array = Unirest.get('https://data.cityofchicago.org/resource/azpf-uc4s.json').body
      create_condoms(api_array)
    end

    def self.search(search_keyword)
      api_array = Unirest.get("https://data.cityofchicago.org/resource/azpf-uc4s.json?$q=#{search_keyword}").body
      create_condoms(api_array)
    end

    def self.create_condoms(api_array)
      condoms = []
      api_array.each do| condom_info|
        condoms << Condom.new(condom_info)
      end
      condoms
    end

    private_class_method :create_condoms

  end
end
