use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my %ints;
    foreach my $i (sort { $a <=> $b } @ints) {
        $ints{$i} = scalar(keys(%ints))+1 unless exists $ints{$i};
    }
    my @result;
    foreach my $i (@ints) {
        push @result, $ints{$i};
    }

    return \@result;
}

is_deeply(run(55, 22, 44, 33), [4, 1, 3, 2], "Example 1");
is_deeply(run(10, 10, 10), [1, 1, 1], "Example 2");
is_deeply(run(5, 1, 1, 4, 3), [4, 1, 1, 3, 2], "Example 3");
