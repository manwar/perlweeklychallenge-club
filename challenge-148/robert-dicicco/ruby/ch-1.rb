### Author: Robert DiCicco
### Date: 18-JAN-2022
### Challenge 148 Eban Numbers

### Ruby Version

require 'humanize'

n = 0

while n < 100
    if n.humanize.count("e").zero?
        print n.to_s + " "
    end

    n = n + 1
end

puts
