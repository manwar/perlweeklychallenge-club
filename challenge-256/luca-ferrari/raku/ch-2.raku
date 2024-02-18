#!raku

#
# Perl Weekly Challenge 256
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
#

sub MAIN( Str $left, Str $right ) {
    my $output = ( $left.comb Z $right.comb ).flat.join;

    if ( $left.chars > $right.chars ) {
	$output ~= $left.comb[ $right.chars .. * ].join;
    }
    elsif ( $left.chars < $right.chars ) {
	$output ~= $right.comb[ $left.chars .. * ].join;
    }

    $output.say;
}
