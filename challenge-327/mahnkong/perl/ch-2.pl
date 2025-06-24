use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my %pairs;

    for (my $i = 0; $i < scalar(@ints); $i++) {
        for (my $j = 0; $j < scalar(@ints); $j++) {
            next if $i == $j;
            $pairs{abs($ints[$i] - $ints[$j])}->{join(":", sort { $a <=> $b } ($ints[$i], $ints[$j]))} = undef;
        }
    }


    foreach my $key (sort { $a <=> $b } keys(%pairs)) {
        my @result;
        foreach my $pair (sort(keys(%{$pairs{$key}}))) {
            push @result, [ split(':', $pair) ];
        }
        return [ @result ];
    }
}

is_deeply(run(4, 1, 2, 3), [[1, 2], [2, 3], [3, 4]], "Example 1");
is_deeply(run(1, 3, 7, 11, 15), [[1, 3]], "Example 2");
is_deeply(run(1, 5, 3, 8), [[1, 3], [3, 5]], "Example 3");
