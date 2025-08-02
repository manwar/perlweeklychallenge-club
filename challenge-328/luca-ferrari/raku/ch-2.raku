#!raku

#
# Perl Weekly Challenge 328
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-328>
#

sub MAIN( Str $string is copy where { $string ~~ / ^ <[a..zA..Z]>+ $ / } ) {

    my @chars = $string.lc.comb;
    my @result;
    my $index = 0;

    while ( $index < @chars.elems ) {
	@result.push: @chars[ $index ] and last if ( $index == @chars.elems - 1 );

	if ( @chars[ $index ] ne @chars[ $index + 1 ] ) {
	    @result.push: @chars[ $index ];
	    $index++;
	}
	else {
	    $index += 2;
	}
    }

    @result.join.say;
}
