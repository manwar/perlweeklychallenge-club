#!raku

#
# Perl Weekly Challenge 246
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
#

sub MAIN( *@nums where { @nums.elems == 5 && @nums.grep( * ~~ Int ).elems == @nums.elems }  ) {

    for 2 ..^ @nums.elems {
	# a[n] = p * a[n-2] + q * a[n-1] with n > 1

	my $ok = False;
	for 1 .. Inf -> $p {
	    for 1 .. Inf -> $q {
		if ( @nums[ $_ ] == ( $p * @nums[ $_ - 2 ] + $q * @nums[ $_ - 1 ] )
			|| @nums[ $_ ] == ( $p * -1 * @nums[ $_ - 2 ] + $q * @nums[ $_ - 1 ] )
			|| @nums[ $_ ] == ( $p * -1 * @nums[ $_ - 2 ] + $q * -1 * @nums[ $_ - 1 ] )
			|| @nums[ $_ ] == ( $p * @nums[ $_ - 2 ] + $q * -1 * @nums[ $_ - 1 ] ) ) {
		    $ok = True;
		    last;
		}
	    }

	    last if $ok;
	}

	
	'False'.say and exit if  ! $ok;
    }

    'True'.say;
}
