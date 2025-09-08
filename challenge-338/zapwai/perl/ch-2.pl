use v5.38;
use List::Util qw(min max);
    
sub proc($ref1, $ref2) {
    my @a1 = @$ref1;
    my @a2 = @$ref2;
    my ($max1, $max2) = (max(@a1), max(@a2));
    my ($min1, $min2) = (min(@a1), min(@a2));
    my ($diff1, $diff2) = (
	$max2 - $min1,
	$max1 - $min2
    );
    say "Output: " . max($diff1, $diff2);
}

my @arr1 = (4,5,7);
my @arr2 = (9,1,3,4);
proc(\@arr1, \@arr2);
