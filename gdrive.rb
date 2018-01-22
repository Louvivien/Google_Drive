require 'google_drive'
require 'pry'
require 'json'
require 'pp'
require 'CSV'

class Scrapping

    def initialize
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    # See this document to learn how to create config.json:
    # https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
    session = GoogleDrive::Session.from_config("config.json")
    @ws = session.spreadsheet_by_key("1qOH4xdbIRHUsx9S1C-rMrCce61knpRujyWc7GMX_KE0").worksheets[0]
    end

    def get_my_hash

    my_hash = {}
    require_relative '../D9_Scrapping/townhall'
    my_hash = all
    return my_hash
    end

#Method to go through the hash
    def go_through_hash(my_hash)
      puts "Writing all the values on Google Drive"
      puts "====================================================================="
      i = 1
      @my_hash = my_hash
      @my_hash.each do |key, value|

        @ws[i,1] = key
        @ws[i,2] = value

        i = i+1
        @ws.save
      end
    end

#Method to write a hash in JSON

    def write_json(my_hash)
      my_hash = my_hash

      File.open("townhall.json","w") do |f|
        f.write(my_hash.to_json)
      end
    end

#Method to write a hash in CSV

    def write_CSV(my_hash)

      my_hash = my_hash


        CSV.open("data.csv", "wb") {|csv|
          my_hash.to_a.each {|elem|
            csv << elem
            }
          }

    end

end
scrapping_hash = {}

test = Scrapping.new
scrapping_hash = test.get_my_hash
#test.go_through_hash(scrapping_hash)
test.write_CSV(scrapping_hash)

