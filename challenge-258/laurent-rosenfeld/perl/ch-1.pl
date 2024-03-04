use strict;
use warnings;
use feature 'say';

sub count_even_digits_ints {
    scalar grep { ! (length($_) % 2) } @_;
}

my @tests = ( [<10 1 111 24 1000>],
              [<111 1 11111>], [<2 8 1024 256>] );
for my $test (@tests) {
    printf "%-20s => ", "@$test";
    say count_even_digits_ints @$test;
}
