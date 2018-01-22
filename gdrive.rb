require 'google_drive'
require 'pry'
require 'json'
require 'pp'



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
}

def writing_json
  json = File.read('input.json')
  obj = JSON.parse(json)

  pp obj

  tempHash = {
    "key_a" => "val_a",
    "key_b" => "val_b"
  }
  File.open("temp.json","w") do |f|
    f.write(tempHash.to_json)
  end
end

end

scrapping_hash = {}

test = Scrapping.new
scrapping_hash = test.get_my_hash


test.go_through_hash(scrapping_hash)

=begin
# Gets list of remote files.
session.files.each do |file|
  p file.title
end

# Uploads a local file.
session.upload_from_file("/path/to/hello.txt", "hello.txt", convert: false)

# Downloads to a local file.
file = session.file_by_title("hello.txt")
file.download_to_file("/path/to/hello.txt")

# Updates content of the remote file.
file.update_from_file("/path/to/hello.txt")
=end
