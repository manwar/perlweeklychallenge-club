use strict;
use warnings;
use feature 'say';

sub concat_vals {
    my @in = @_;
    my $concat;
    while (@in > 1) {
        $concat += (shift @in) . (pop @in);
    }
    $concat += shift @in if @in > 0; # if we have 1 item left
    return $concat;
}

for my $test ([<6 12 25 1>], [<10 7 31 5 2 2>], [<1 2 10>]) {
    printf "%-15s => ", "@$test";
    say concat_vals @$test;
}
