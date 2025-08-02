use v5.36;
use List::Util qw( sum );

my @ints1 = (2, 5, 9, 11, 3); my $k1 = 1;
my @ints2 = (2, 5, 9, 11, 3); my $k2 = 2;
my @ints3 = (2, 5, 9, 11, 3); my $k3 = 0;

proc($k1, @ints1);
proc($k2, @ints2);
proc($k3, @ints3);

sub proc($k, @ints) {
    say "Input: \@ints = (@ints), \$k = $k";
    my $sum = 0;
    my @ind;
    for my $i (0 .. $#ints) {
	my $s = sprintf "%b", $i;
	my @bit = split "", $s;
	my $tally = sum( grep { 1 } @bit );
	push @ind, $i if ($tally == $k);
    }
    $sum += $ints[$_] foreach (@ind);
    say "Output: $sum";
}
