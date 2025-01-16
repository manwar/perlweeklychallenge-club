#!raku

#
# Perl Weekly Challenge 304
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-304>
#

sub MAIN( Int $n, *@bits is copy where { $n > 0 && @bits.elems == @bits.grep( * ~~ /<[01]>/ ).elems } ) {

    my $changes-to-do = $n;

    for 1 ..^ @bits.elems - 2 -> $index {
	if ( @bits[ $index - 1 ] != 1 && @bits[ $index + 1 ] != 1 ) {
	    @bits[ $index ] = 1;
	    $changes-to-do--;
	}
    }

    'True'.say and exit if ( $changes-to-do <= 0);
    'False'.say;
}
