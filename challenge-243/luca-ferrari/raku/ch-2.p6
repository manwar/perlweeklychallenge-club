#!raku

#
# Perl Weekly Challenge 243
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems && @nums.elems >= 1 } ) {
    my $sum = 0;

    for @nums -> $current {
	$sum += [+] ( @nums.map( { ( $current / $_ ).Int }  ) );
    }

    $sum.say;
}
