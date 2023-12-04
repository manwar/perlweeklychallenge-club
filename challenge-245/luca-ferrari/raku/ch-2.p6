#!raku

#
# Perl Weekly Challenge 245
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems
					 && @nums.grep( 0 <= * <= 9 ).elems } ) {

    my $largest = -1;
    for @nums.permutations {
	my $value = $_.join.Int;
	next if $value !%% 3;
	$largest = $value if ( $value > $largest );
    }

    $largest.say;
}
