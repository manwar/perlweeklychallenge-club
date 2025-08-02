use strict;
use warnings;
use feature 'say';

sub relative_sort {
    my ($in1, $in2) = @_;
    my @result;
    my %unsorted;
    $unsorted{$_}++ for @$in1;
    for my $i (@$in2) {
        if (exists $unsorted{$i}) {
            push @result, ($i) x $unsorted{$i};
            $unsorted{$i} = 0;
        }
    }
    push @result, sort map { ($_) x $unsorted{$_}}
        grep { $unsorted{$_} > 0 } keys %unsorted;
    return "@result";
}

my @tests = ( [[2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]],
              [[3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]],
              [[3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]] );
for my $test (@tests) {
    printf "%-15s => ", "@{$test->[1]}";
    say relative_sort @$test[0], @$test[1];
}
