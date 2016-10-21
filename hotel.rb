require 'rubygems'
require 'nokogiri'
require 'open-uri'

days = [ 'Monday    ', 'Tuesday', 'Wednesday', 'Thursday', 'Friday   ', 'Saturday', 'Sunday   ' ]

def get_price(p)
  price = p.css('.price')[0]

  # If the price is a "great rate", the site puts the price inside an <ins> tag
  if price.css('ins').text != '' then
    price.css('ins').text.delete('$').to_i
  # Normal prices are in a <b> tag
  elsif price.css('b').text != '' then
    price.css('b').text.delete('$').to_i
  end
end

def get_week_starting_date(start, week)
  start + (week * 7)
end

def hotel_url(date)
  'https://www.hotels.com/search.do?resolved-location=CITY%3A1532964%3AUNKNOWN%3AUNKNOWN&f-name=DoubleTree%20by%20Hilton%20Hotel%20Tallahassee&as-redirect-page=undefined&f-hotel-id=115299&destination-id=1532964&q-destination=Tallahassee,%20Florida,%20United%20States%20of%20America&q-check-in=' + date.to_s + '&q-check-out=' + (date + 1).to_s + '&q-rooms=1&q-room-0-adults=1&q-room-0-children=0'
  # 'https://www.hotels.com/search.do?resolved-location=CITY%3A1439028%3AUNKNOWN%3AUNKNOWN&f-name=aloft&as-redirect-page=undefined&f-hotel-id=511877&destination-id=1439028&q-destination=Los%20Angeles,%20California,%20United%20States%20of%20America&q-check-in=' + date.to_s + '&q-check-out=' + (date + 1).to_s + '&q-rooms=1&q-room-0-adults=1&q-room-0-children=0'
end

SAMPLE_SIZE = 365

start_date = Date.new(2016, 10, 3)
prices = []
day_counter = []
weeks = []

7.times do |n|
  prices[n] = 0
  day_counter[n] = 0
end

SAMPLE_SIZE.times do |n|
  week = n / 7
  if weeks[n / 7] == nil
    weeks[n / 7] = 0
  end

  next_date = start_date + n

  price = get_price(Nokogiri::HTML(open(hotel_url(next_date))))
  prices[next_date.cwday - 1] += price
  weeks[week] += price

  day_counter[next_date.cwday - 1] += 1

  print "Date: ", next_date.to_s, "\t\t$", price, "\n"

end

print "\nAverage Prices:\n"

prices.each_with_index do |p, n|
  prices[n] /= day_counter[n]
  print days[n], " \t$", prices[n], "\n"
end

_, min_index = prices.each_with_index.min
_, max_index = prices.each_with_index.max
print "\nCheapest Day (avg):\n", days[min_index], "\t$", prices[min_index]
print "\n\nMost Expensive Day (avg):\n", days[max_index], "\t$", prices[max_index]

# print "\n\nWeeks:\n"
#
# weeks.each_with_index do |p, n|
#   print "Week of ", get_week_starting_date(start_date, n), ": $", p, "\n"
# end

weeks.pop

_, min_windex = weeks.each_with_index.min
_, max_windex = weeks.each_with_index.max
print "\nCheapest Week:\n", get_week_starting_date(start_date, min_windex), "\t$", weeks[min_windex]
print "\n\nMost Expensive Week:\n", get_week_starting_date(start_date, max_windex), "\t$", weeks[max_windex]
print "\n"
