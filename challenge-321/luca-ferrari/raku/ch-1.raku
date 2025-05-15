#!raku

#
# Perl Weekly Challenge 321
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
#

sub MAIN( *@numbers where { @numbers.elems %% 2 && @numbers.elems == @numbers.grep( * ~~ Int ).elems } ) {

    my @averages;
    for 0 ..^ @numbers.elems / 2 {
	@averages.push: ( [+] @numbers.sort[ $_, * - 1 - $_ ] ) / 2;
    }

    @averages.min.say;
}
