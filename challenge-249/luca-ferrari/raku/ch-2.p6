#!raku

#
# Perl Weekly Challenge 249
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
#

sub MAIN( $string  ) {

    my @chars = $string.comb;
    for ( 0 .. @chars.elems ).permutations -> $perm {
	my $ok = True;
	for 0 ..^ $perm.elems - 1 -> $i {
	    $ok = False and next if @chars[ $i ] ~~ 'D' && $perm[ $i ] < $perm[ $i + 1 ];
	    $ok = False and next if @chars[ $i ] ~~ 'I' && $perm[ $i ] > $perm[ $i + 1 ];
	    last if !$ok;
	}

	$perm.join(", ").say and last if $ok;
    }
}
