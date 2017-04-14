require 'csv'

values = []

def shorten
   return [*('a'..'z'),*('0'..'9')].shuffle[0,7].join
end

CSV.foreach("db/urls.csv") do |row|

  long_url = row[0].match(/http:\/\/.+\)/).to_s.delete(")")
  short_url = shorten
  click_count = 0
  values << "('#{long_url}','#{short_url}', #{click_count})"

end

values = values.join(",") + ";"

Url.transaction do
  Url.connection.execute "INSERT INTO urls (long_url, short_url, click_count) VALUES #{values}"
end 

# values =[]

# text = File.open("urls").read
# text.each_line do |line|	
# 	values << line[0..-2]
# end

# values = values.join

# Url.transaction do
#   Url.connection.execute "INSERT INTO urls (long_url) VALUES #{values}"
# end

# Url.transaction do
# 	values.each do |x|
# 	  Url.connection.execute "INSERT INTO urls (long_url) VALUES #{x}"
# 	end
# end

# require 'CSV'

# values = []

# CSV.foreach("urls.csv") do |row|

#   long_url = row[0].match(/http:\/\/.+\)/).to_s.delete(")")
#   short_url = shorten
#   values << "('#{long_url}','#{short_url}')"

# end

# values = values.join(",") + ";"

# click_count = 0

# Url.transaction do
#   Url.connection.execute "INSERT INTO urls (long_url,short_url) VALUES #{values}"
# end 