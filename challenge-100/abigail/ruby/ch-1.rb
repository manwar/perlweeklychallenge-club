#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |_|
    #
    # Parse data. Note that we have to map the hours and
    # minutes from strings to integers.
    #
    m = _ . match /(?<hour>[0-9]+):(?<minute>[0-9]+)\s*(?<ampm>[ap]?)/
    hour   = m [:hour]   . to_i
    minute = m [:minute] . to_i
    ampm   = m [:ampm]

    #
    # Calculate the new AM/PM marker
    #
    new_ampm = ampm == "" ? hour >= 12 ? "pm" : "am" : ""

    #
    # Calculate the new hour
    #
    hour %= 12

    if   ampm == "" && hour == 0
    then hour =  12
    end

    if   ampm == "p"
    then hour += 12
    end

    #
    # Print the result
    #
    puts sprintf("%02d:%02d%s", hour, minute, new_ampm)
end
