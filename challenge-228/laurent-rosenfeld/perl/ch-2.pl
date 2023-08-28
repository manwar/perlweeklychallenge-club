use strict;
use warnings;
use feature 'say';

sub empty_array {
    my @in = @_;
    my $count = 0;
    while (1) {
        my $val = shift @in;
        my $pushback = 0;
        for my $item (@in) {
            $pushback = 1 if $val > $item;
            last if $pushback;
        }
        push @in, $val if $pushback;
        $count++;
        last unless @in;
    }
    return $count;
}

for my $test ( [<3 4 2>], [<1 2 3>],
               [<3 2 1>], [<4 7 2 9 1>] ) {
  printf "%-10s => ", "@$test";
  say empty_array @$test;
}
