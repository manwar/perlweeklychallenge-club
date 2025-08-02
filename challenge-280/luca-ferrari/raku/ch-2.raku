#!raku

#
# Perl Weekly Challenge 280
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
#

sub MAIN( Str $input is copy where { $input ~~ / <[|]>+ / } ) {

    # avoid the last bar to trigger an empty pair
    if $input ~~ / <[|]> $ / {
	$input = $input.subst( / <[|]> $ /, '' );
    }

    my @pairs;
    for $input.split( '|' ) -> $k, $v {
	next if ! $k || ! $v;
	@pairs.push: $k => $v;
    }

    @pairs.map( { $_.key.comb.grep( * ~~ '*' ).elems } ).sum.say;

}
