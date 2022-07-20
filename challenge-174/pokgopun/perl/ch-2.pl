use strict;
use warnings;

foreach my $p ([1,0,2], [0,2,1], [@ARGV]){
	my $n = @$p;
	next unless $n;
	printf "\npermuation_rank([%s]) = %d\n", join(",", @$p), my $r = &permutation_rank(@$p);
	printf "rank_permutation([%s],%d) = [%s]\n\n", join(",",0..$n-1), $r, join(",",&rank_permutation($n, $r));
}

sub factorial{
	my $n = shift;
	return $n ? $n * factorial($n-1) : 1;
}

sub rank_permutation(){
	my ($n,$r) = @_;
	my $fact = &factorial($n-1);			# compute (n-1) factorial
    	my @digits =  0..$n-1;				# all yet unused digits
    	my @p;						# build permutation
	my $q;
	foreach my $i (0..$n-1){			# for all digits except last one
		$q = int($r / $fact);			# by decomposing r = q * fact + rest
		$r %= $fact;
		push @p, $digits[$q];
#		$digits[$q] = undef;			# remove this digit p[i];
#		@digits = grep{defined} @digits;
		#		use splice instead
		splice @digits, $q, 1;
		$fact /= $n - 1 - $i if $i != $n - 1;	# weight of next digit
	}
	return @p;
}

sub permutation_rank{
	my $p = \@_;
	my $n = @_;
	my $fact = &factorial($n-1);			# compute (n-1) factorial
	my ($q, $r);
    	my @digits =  0..$n-1;				# all yet unused digits
	foreach my $i (0..$n-2){			# for all digits except last one
		$q = 0;
		{
			last if $digits[$q]==$p->[$i];
			$q++;
			redo;
		}
		$r += $fact * $q;
#		$digits[$q] = undef;
#		@digits = grep{defined} @digits;	# remove this digit p[i]
		#		use splice instead
		splice @digits, $q, 1;
		$fact /= $n - 1 - $i;			# weight of next digit
	}
	return $r
}
