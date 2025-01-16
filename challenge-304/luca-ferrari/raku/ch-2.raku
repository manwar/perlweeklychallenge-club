#!raku

#
# Perl Weekly Challenge 304
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-304>
#

sub MAIN( Int $n, *@numbers where { 0 < $n <= @numbers.elems } ) {

    my @result = 0;

    for 0 ..^ @numbers.elems - $n -> $index {
	my $current-avg   = ( [+] @numbers[ $index .. $index + $n - 1 ] ) / $n;
	my $previous-avg =  ( [+] @result ) / $n;
	@result = @numbers[ $index .. $index + $n - 1 ] if ( $current-avg > $previous-avg );
    }

    ( ( [+] @result ) / $n ).say;
}
