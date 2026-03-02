#!raku

#
# Perl Weekly Challenge 362
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-362>
#

sub MAIN( Str $string where { $string ~~ / ^ <[a..z]>+ $ / } ) {
    my @chars  = $string.comb;
    my $result = "";

    for 0 ..^ @chars.elems {
	$result ~= @chars[ $_ ] x ( $_ + 1 );
    }

    $result.say;
}
