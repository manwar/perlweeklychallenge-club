use strict;
use warnings;

my %digit_weight;
sub digit_weight {
    my ($num)= @_;

    return $digit_weight{$num} //= do {
        die "Not expecting a negative number ($num)" if $num < 0;
        my $n = $num;
        my $count = 0;

        while ($n > 9) {
            $count++;
            my $tmp = 1;
            for my $digit (split //, $n) {
                $tmp *= $digit;
            }
            $n = $tmp;
        }
        $count;
    };
}

sub persistence_sort {
    my ($array) = @_;
    my @sorted= sort { digit_weight($a) <=> digit_weight($b) || $a <=> $b } @$array;
    return \@sorted;
}

use Test::More;
foreach my $tuple (
    [ [ 15, 99,  1, 34], [  1, 15, 34, 99 ] ],
    [ [ 50, 25, 33, 22], [ 22, 33, 50, 25 ] ],
    [ [ 12347, 2347, 347, 47, 7], [ 7, 47, 347, 2347, 12347 ] ],
) {
    my ($input, $want) = @$tuple;
    my $output = persistence_sort($input);
    is("@$output","@$want","persistence_sort(@$input)");
}
done_testing();
