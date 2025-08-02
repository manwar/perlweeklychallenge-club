#!raku

#
# Perl Weekly Challenge 255
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-255>
#

sub MAIN( Str :$a, Str :$b where { $b.chars == $a.chars + 1 } ) {
    my $classification = BagHash.new: $b.comb;
    for $a.comb {
	$classification{ $_ }--;
	$classification{ $_ }:delete if ( $classification{ $_ } <= 0 );
    }

    $classification.keys.head.say;
}
