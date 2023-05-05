#!raku

#
# Perl Weekly Challenge 215
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-215/>
#

sub MAIN( :$count is copy where { $count >= 0 } ,
		*@digits is copy where { @digits.grep( 0 <= *.Int <= 1  ).elems == @digits.elems }  ) {

    my $done = False;
    while $count {
	$done = False;
	for 1 ..^ @digits.elems - 1 {
	    if ( @digits[ $_ ] == 0 && @digits[ $_ - 1 ] == 0 && @digits[ $_ + 1 ] == 0 ) {
		@digits[ $_ ] = 1;
		$count--;
		$done = True;
		last;
	    }
	}

	'0'.say and exit if ! $done;
    }

    '1'.say and exit if ! $count;
    '0'.say;
}
