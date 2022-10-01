use strict;
use warnings;
use feature qw/say/;

for my $test (['a 1 2 b 0', '3 c 4 d'], ['1 2', 'p q r', 's 3', '4 5 t']) {
    my (@letters, @digits);
    for my $item (@$test) {
        push @letters, grep { /[a-zA-Z]+/ } split /\s+/, $item;
        push @digits, grep { /\d+/ } split /\s+/, $item;;
    }
    say  "@letters \n@digits";
}
