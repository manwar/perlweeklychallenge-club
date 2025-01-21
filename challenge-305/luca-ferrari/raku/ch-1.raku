#!raku

#
# Perl Weekly Challenge 306
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
#

sub MAIN( *@bits where { @bits.elems == @bits.grep( * ~~ /<[01]>/ ).elems } ) {

    my @primes;
    for 0 ..^ @bits.elems {
	@primes.push: True and next if ( @bits[ 0 .. $_ ].join.parse-base( 10 ).is-prime );
	@primes.push: False;
    }

    @primes.join( ', ' ).say;
}
