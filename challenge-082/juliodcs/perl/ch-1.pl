use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub factors_to_hash($num) {
    map { $_ => undef } (grep { $num % $_ == 0 } (1 .. $num/2), $num)
}

my %a = factors_to_hash shift;
my %b = factors_to_hash shift;

say join q(, ), grep { exists $a{$_} } sort keys %b;
