use v5.30;
use List::Util qw( max min );
my $matrix = [ [ 3,  7,  8],
	       [ 9, 11, 13],
	       [15, 16, 17],
	   ];
say "Input: \$matrix = [";
say "\t[@$_]" foreach (@$matrix);
say "\t];";
my $h = @$matrix;
my $w = scalar @{$$matrix[0]};
my $luck = -1;
my @min;
for my $i (0 .. $h - 1) {
    push @min, min (@{$$matrix[$i]});
}
my @max;
for my $j (0 .. $w - 1) {
    my @col = map { $$matrix[$_][$j] } (0 .. $h - 1) ;
    push @max, max @col;
}
loop: for my $val (@min) {
    for my $val2 (@max) {
	if ($val == $val2) {
	    $luck = $val;
	    last loop;
	}
    }
}
say "Output: $luck";
