use v5.40;
use Data::PowerSet qw( powerset );

sub xorsum(@a) {
    return $a[0] if (@a == 1);
    my $sum = 0;
    $sum ^= $_ for (@a);
    return $sum;
}

sub proc(@ints) {
    say "Input:  \@ints = @ints";
    my $pow = powerset(@ints);
    my $tot = 0;
    for my $p (@$pow) {
	#print "\t\t@$p\t:";
	my $x = xorsum(@$p);
	#say "xorsum: $x";
	$tot += $x;
    }
    say "Output: $tot";
}

my @ints = (1,3);
proc(@ints);
@ints = (5,1,6);
proc(@ints);
@ints = (3, 4, 5, 6, 7, 8);
proc(@ints);
