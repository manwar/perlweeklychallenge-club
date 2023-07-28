#!/usr/bin/env perl
use v5.38;

# let's use the core modules for date manipulation
use Time::Piece;
use Time::Seconds qw( ONE_DAY );

# get the year from the command line
my $year = shift @ARGV
  or die "usage: $0 year\n";

# do bounds checking as specified in the problem
if ($year < 1753 || $year > 9999) {
  die "Only years between 1753 to 9999 are allowed ($year is out of range)\n";
}

# create an object for Jan 01 of the given year
my $t = Time::Piece->strptime("$year-01-01", "%Y-%m-%d")
                   ->truncate(to => 'day');

# find the first friday
# in Time::Piece->wday, 1 = Sunday, 6 = Friday
while ( $t->wday != 6) {
  $t += ONE_DAY; # add 1 day
}

# now keep adding 7 days to the date until the year changes,
# noting how many times the day of the month is 13
my $thirteen_count = 0;
while ( $t->year == $year ) {
  $thirteen_count++ if $t->mday == 13;
  $t += ONE_DAY * 7;
}

say "Input: \$year = $year";
say "Output: $thirteen_count";