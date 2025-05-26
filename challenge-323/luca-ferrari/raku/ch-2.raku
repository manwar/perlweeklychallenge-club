#!raku

#
# Perl Weekly Challenge 323
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
#

sub MAIN( Int $income, *@taxes where { @taxes.grep( * ~~ Int ).elems == @taxes.elems } ) {
    my $value = 0;
    my $last = 0;

    say @taxes;
    for @taxes -> $up-to, $pct {
	next if $last > $income;
	$value += ( min( $up-to, $income ) - $last )  * $pct / 100;
	$last = $up-to;
    }

    $value.say;

}
