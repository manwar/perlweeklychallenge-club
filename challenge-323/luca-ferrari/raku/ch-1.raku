#!raku

#
# Perl Weekly Challenge 323
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
#

sub MAIN( *@operations ) {
    my $value = 0;
    for @operations {
	$value++ and next if ( $_ ~~ / '++' / );
	$value-- and next if ( $_ ~~ / '--' / );
    }

    $value.say;
}
