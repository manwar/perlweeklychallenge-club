use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @intervals = ([2,7], [3,4], [5,9], [10,12], [15,19], [18,22], [0,1], [24,35], [25,30]);
@intervals =  sort { $a->[0] <=> $b->[0] } @intervals;
my @merged;
# say Dumper \@intervals;
my $current = $intervals[0];
for my $i (1..$#intervals) {
    if ($intervals[$i][0] > $current->[1]) {
        push @merged, $current;
        $current = $intervals[$i];
    } else {
        next unless $intervals[$i][1] > $current->[1];
        $current->[1] = $intervals[$i][1];
    }
}
push @merged, $current;
say Dumper \@merged;
