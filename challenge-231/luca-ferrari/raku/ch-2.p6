#!raku

#
# Perl Weekly Challenge 231
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-231/>
#

sub MAIN( *@passengers ) {
    my $count = 0;
    for @passengers {
	next if $_ !~~ / ^ (\d ** 10 ) (<[MF]>) (\d ** 2 ) (\d ** 2) $ /;
	my ( $phone, $gender, $age, $seat ) = $/.Array;
	$count++ if ( $age >= 60 );
    }

    $count.say;
}
