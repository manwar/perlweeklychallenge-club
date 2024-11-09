#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-04
use utf8;     # Week 294 - task 2 - Next permutation
use warnings; # Peter Campbell Smith
use Algorithm::Combinatorics 'permutations';
binmode STDOUT, ':utf8';

next_permutation(1, 2, 3);
next_permutation(2, 1, 3);
next_permutation(3, 1, 2);
next_permutation(1, 2, 4, 3);
next_permutation(9, 11, 5, 3, 1);
next_permutation(4, 3, 2, 1);

my @ints;
push @ints, int(rand(20)) for 0 .. 9;
next_permutation(@ints);

sub next_permutation {
    
    my (@ints, @sort_ints, $j, $iter, $next, $ok);
    
    # initialise
	@ints = @_;
	@sort_ints = sort { $a <=> $b } @ints;
	
	# if @ints is monotonically decreasing this is the last
	$ok = 0;
	for $j (1 .. $#ints) {
		$ok |= 1 if $ints[$j - 1] < $ints[$j];
	}	
	
    # get current permutation in lexicographic order
	if ($ok) {
		$iter = permutations(\@sort_ints);
		ITER: while ($next = $iter->next) {
			for $j (1 .. $#ints) {
				next ITER unless $ints[$j] == $next->[$j];
			}	
			last ITER;
		}
		$next = $iter->next;   # the next iteration
	}
  
    say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	say qq[Output:         ] . ($ok ? '(' . join(', ', @$next) . ')' :
		'none: this is the last iteration');
}
