#!raku

#
# Perl Weekly Challenge 309
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-309>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {

    my $min = Inf;
    for @nums -> $current {
	my $found = @nums
		     .grep( * != $current )
		     .map( { abs( $current - $_.Int ) } )
		     .min;
	$min = $found if $min > $found;
    }

    $min.say;
}
