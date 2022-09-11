#!ruby.exe

require 'date'

# AUTHOR: Robert DiCicco
# DATE: 2022-09-08
# Challenge #181 Hot Day ( Ruby )

$daytemps = Hash.new

def compareTemps

  $daytemps.each do |mydate, mytemp|

    d = Date.parse(mydate)

    d = d - 1

    prevday = d.strftime("%Y-%m-%d")

    if ! $daytemps.has_key?(prevday)

      next

    end

    if $daytemps[mydate] > $daytemps[prevday]

      puts(mydate)

    end

  end

end

def setupHashArray

  File.foreach("temperature.txt") { |line|

    line = line.gsub(/[[:space:]]/, '')

    (mydate, mytemp) = line.split(',')

    $daytemps[mydate.chomp] = mytemp.chomp

  }

end

def main

  setupHashArray()

  compareTemps()

end

main()
