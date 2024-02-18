use strict;
use warnings;
use feature 'say';

sub merge_strings  {
    my ($str1, $str2) = @_;
    my @let1 = split //, $str1;
    my @let2 = split //, $str2;
    my $end = scalar @let1 > scalar @let2 ? $#let1 : $#let2;
    my @result = map { ($let1[$_] // "") .
                       ($let2[$_] // "") } 0..$end;
    return join "", @result;
}

my @tests = ([<abcd 1234>], [<abc 12345>], [<abcde 123>]);
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say merge_strings $test->[0], $test->[1];
}
