use strict;
use warnings;
use feature 'say';

sub good_integer {
    my $in = shift;
    return -1 if $in =~ /(\d)\1{3}/;
    return  $1 x 3 if $in =~ /(\d)\1{2}/;
}

my @tests = (12344456, 123444456, 1233334, 10020003);
for my $test (@tests) {
    printf "%-10s => ", $test;
    say good_integer $test;
}
