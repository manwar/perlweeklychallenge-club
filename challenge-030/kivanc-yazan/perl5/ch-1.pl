#!/usr/bin/env perl
use warnings;
use strict;
use DateTime;

# Problem:
# Write a script to list dates for Sunday Christmas between 2019
# and 2100. For example, 25 Dec 2022 is Sunday.

# Answer:
# Let's use DateTime.

foreach my $year (2019..2100){
  my $christmas = DateTime->new({
    year  => $year,
    month => 12,
    day   => 25,
  });
  if ($christmas->dow() == 7){
    print "25 Dec $year is Sunday\n";
  }
}

# Output:
# 25 Dec 2022 is Sunday
# 25 Dec 2033 is Sunday
# 25 Dec 2039 is Sunday
# 25 Dec 2044 is Sunday
# 25 Dec 2050 is Sunday
# 25 Dec 2061 is Sunday
# 25 Dec 2067 is Sunday
# 25 Dec 2072 is Sunday
# 25 Dec 2078 is Sunday
# 25 Dec 2089 is Sunday
# 25 Dec 2095 is Sunday
