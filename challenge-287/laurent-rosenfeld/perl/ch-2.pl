use strict;
use warnings;
use feature 'say';

sub valid_number {
    my $in = shift;
    return "True" if $in =~
      /^[+-]?         # start of string & optional + or - sign
        ( \d+\.?      # digit(s) followed by a dot
        | \d*\.\d+)   # or digits with a dot inside or before
        ([eE][+-]\d+)? # optional positive or negative exponent
      $/x;            # end of string & option to enable comments
    return "False";
}
my @tests = qw<1 a . 1.2e4.2 -1 +1E-8 .44 16 12.5 5e17e3 foo>;
for my $test (@tests) {
    printf "%-10s => ", $test;
    say valid_number $test;
}
