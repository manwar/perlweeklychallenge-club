#ruby.exe

require 'date'

# AUTHOR: Robert DiCiccco
# DATE: 2022-07-25
# Challenge 175 Last Sunday ( Ruby )

def CreateDateObject( y, m)

  td = Date.new(y,m,1).next_month.prev_day

  return td

end

year = ARGV[0].to_i

for m in 1..12 do

  td = CreateDateObject(year,m)

  wd = td.wday

  if wd != 7

    puts (td - wd).to_s

  else

    puts td

  end

end
