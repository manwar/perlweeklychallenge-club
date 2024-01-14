#!raku

#
# Perl Weekly Challenge 251
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems and @nums.elems %% 2 } ) {
    my $sum = 0;
    for @nums -> $l, $r {
	$sum += $l ~ $r;
    }

    $sum.say;
}
