#!raku

#
# Perl Weekly Challenge 361
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-361>
#


sub MAIN( Int $number is copy
	  where { 0 < $number <= 100 } ) {

    my @fib = 0, 1, 1;
    my @zeckendorf;

    while ( @fib.elems < $number ) {
	@fib.push: @fib[ * - 1 ] + @fib[ * - 2 ];
    }

    for @fib.reverse {
	if ( $_ <= $number ) {
	    @zeckendorf.push: $_;
	    $number -= $_;
	}

	last if $number <= 0;
    }

    @zeckendorf.join( ', ').say;
}
