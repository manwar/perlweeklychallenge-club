use v5.38;
use List::Util "sum", "max";

sub proc(@matrix) {
    my @sum;
    for my $i (0 .. $#matrix) {
	push @sum, sum(@{$matrix[$i]});
    }
    say "Output: " . max(@sum);
}

my @matrix = ([4,  4, 4, 4],
	      [10, 0, 0, 0],
	      [2,  2, 2, 9]);
proc(@matrix);
