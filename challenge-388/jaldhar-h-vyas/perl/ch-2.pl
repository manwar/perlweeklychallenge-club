#!/usr/bin/perl
use 5.40.1;
use warnings;

sub permute(@arr) {
	if (scalar @arr < 2) {
		return \@arr;
	}

    my @permutations;

    my @idx = keys @arr;
    while ( push @permutations, [@arr[@idx]] ) {
        my $p = scalar @idx - 1;
        while ($idx[$p-1] >= $idx[$p]) {
            --$p;
        }
        my $q = $p;
        if (!$q) {
            last;
        }
        push @idx, reverse splice @idx, $p;
        while ($idx[$p-1] > $idx[$q]) {
            ++$q;
        }
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }

    return @permutations;
}

my ($n) = @ARGV;
my @participants = 1 .. $n;
my $count = 0;

PERMUTATION: for my $perm (permute(@participants)) {
	for my $i (keys @participants) {
		if ($participants[$i] == $perm->[$i]) {
			next PERMUTATION;
		}
	}
	$count++;
}

say $count;
