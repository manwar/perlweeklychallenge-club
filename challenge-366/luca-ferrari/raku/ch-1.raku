#!raku

#
# Perl Weekly Challenge 366
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-366>
#

sub MAIN( *@words ) {
    my $string = @words[ * - 1 ];
    my @matches;

    for 0 ..^ @words.elems - 1 {
	my $prefix = @words[ $_ ];
	@matches.push: $prefix if $string ~~ / ^ $prefix  /;
    }

    @matches.elems.say;
}
