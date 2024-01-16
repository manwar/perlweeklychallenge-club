use strict;
use warnings;
use feature 'say';

sub alphanum_string {
    my @out = map {  /^\d+$/ ? 0 + $_ : length $_ } @_;
    return (sort { $a <=> $b } @out)[-1];
}

for my $test ( ["perl", "2", "000", "python", "r4ku"],
    ["001", "1", "000", "0001"]) {
    say alphanum_string @$test;
}
