#!raku

#
# Perl Weekly Challenge 366
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-366>
#

sub MAIN( Str $str ) {
    say 0 and exit if $str !~~ / '?' /;

    my ( $hours, $minutes ) = $str.split( ':' );
    my ( $left, $right ) = $hours.comb;

    my ( @a, @b );
    if ( $left eq '?' ) {
	@a.push: [ 0, 1, 2 ];
    }
    else {
	@a.push: $left.Int;
    }

    if ( $right eq '?' ) {
	@b.push: $_ for 0 .. 9;
    }
    else {
	@b.push: $right.Int;
    }


    my @hours;
    @hours = ( @a X~ @b )>>.Int.Array.grep( * <= 23 );

    @a = ();
    @b = ();
    ( $left, $right ) = $minutes.comb;

    if ( $left eq '?' ) {
	@a.push: $_ for 0 .. 9;
    }
    else {
	@a.push: $left.Int;
    }

    if ( $right eq '?' ) {
	@b.push: $_ for 0 .. 9;
    }
    else {
	@b.push: $right.Int;
    }

    my @minutes = ( @a X~ @b )>>.Int.Array.grep( * <= 59 );

    my @valid-times;
    for @hours -> $h {
	for @minutes -> $m {
	    @valid-times.push: "%02d:%02d".sprintf( $h, $m );
	}
    }


    @valid-times.elems.say;
}
