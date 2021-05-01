use strict;
use warnings;
use feature "say";

# simulate a text file with an array of strings
my @tests = (" 0044 1148820341 42 ", "  +44 1148820342 abc",
            " 44-11-4882-0343 ", " (44) 1148820344 foo (39) 1148820345", " 00 1148820346");

for my $str (@tests) {
    say $1 while $str =~ / ( (?: \d {4} | \+ \d\d | \( \d\d \)  ) \s+ \d{10} ) /gx;
}
