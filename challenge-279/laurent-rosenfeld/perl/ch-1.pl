use strict;
use warnings;
use feature 'say';

sub sort_letters {
    my @letters = @{$_[0]};
    my @indices = @{$_[1]};
    return map $_->[0], sort { $$a[1] <=> $$b[1] }
    map [ $letters[$_], $indices[$_] ], 0..$#letters;
}

my @tests = ( [ [< R E P L>], [<3 2 1 4>] ],
              [ [<A U R K>], [<2 4 1 3>] ],
              [ [<O H Y N P T>], [<5 4 2 6 1 3>] ] );
for my $test (@tests) {
    printf "%-14s => ", "@{$test->[0]}";
    say sort_letters $test->[0], $test->[1];
}
