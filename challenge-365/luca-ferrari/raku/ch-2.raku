#!raku

#
# Perl Weekly Challenge 365
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
#

sub MAIN( Str $sentence ) {
    my @tokens;
    for ( $sentence.split( /\s+/ ) ) {
	next if $_ ~~ / <[0..9]> /;
	next if $_ ~~ / <[A..Z]> '-' /;
	next if $_ ~~ / '-' <[A..Z]> /;
	next if $_ ~~ / <[!.,]> .+ /;

	@tokens.push: $_;
    }

    @tokens.elems.say;
}
