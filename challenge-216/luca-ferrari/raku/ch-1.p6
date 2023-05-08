#!raku

#
# Perl Weekly Challenge 216
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-216/>
#

sub MAIN( *@strings is copy ) {
    my @registration-code = @strings.pop.comb;

    # first implementation
    for @strings -> $word {
	my @result.push: @registration-code.grep( $_ ) for $word.comb;
	say $word if @result.join ~~ $word;
    }

    # second implementation
    my $sorted-registration-code = @registration-code.sort.join;
    for @strings -> $word {
	say $word if ( $sorted-registration-code ~~ / ^  { $word.comb.sort.join } / );
    }

}
