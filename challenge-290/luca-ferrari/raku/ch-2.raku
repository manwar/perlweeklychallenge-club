#!raku

#
# Perl Weekly Challenge 290
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
#

sub MAIN( $digits ) {

    my @numbers = $digits.comb( :skip-empty ).grep( * ~~ /\d/ );
    my $payload = @numbers[ * - 1 ];

    my @checksums;
    my $last;
    for 2 .. @numbers.elems {
	next if ( $last && $last == @numbers[ * - $_ ] );

	my $current = @numbers[ * - $_ ] * 2;
	$current = $current.comb( :skip-empty ).map( *.Int ).sum if ( $current > 9 );
	@checksums.push: $current;
	$last = @numbers[ * - $_ ];
    }


    say 'True' and exit if ( ( @checksums.sum + $payload ) %% 10 );
    say 'False';
}
