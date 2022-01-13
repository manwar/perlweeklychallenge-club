#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |_|
    puts _ . gsub "e", "E"
    puts _ . count "e"
end
