#!raku

#
# Perl Weekly Challenge 217
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-217/>
#

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my $max = 0;
    for @list.permutations {
	$max = $_.join if ( $_.join.Int > $max );
    }

    $max.say;
}
