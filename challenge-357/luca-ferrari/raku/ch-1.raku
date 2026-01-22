#!raku

#
# Perl Weekly Challenge 357
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
#

sub MAIN( Int $value is copy
	  where { $value < 10000 } ) {
    my $kaprekar = 6174;
    my $iterations = 0;

    while ( $value != $kaprekar ) {
	$value = $value.comb.sort( { $^b <=> $^a } ).join.Int - $value.comb.sort.join.Int;
	$iterations++;
    }

    $iterations.say;
}
