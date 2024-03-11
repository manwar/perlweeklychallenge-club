#!raku

#
# Perl Weekly Challenge 259
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
#

sub MAIN( $date,
	  Int $offset is copy,
	  *@holidays
				where { $date ~~ / ^ \d ** 4 <[-]>\d ** 2 <[-]> \d ** 2 $ / and $offset > 0 } ) {

    my $day = DateTime.new( $date, formatter => { sprintf "%04d-%02d-%02d", .year, .month, .day } );


    while ( $offset > 0 ) {
	$day .= later( days => 1 );

	# skip weekends
	while ( $day.day-of-week == any( 7, 6 ) ) {
	    $day .= later( days => 1 );
	}

	while ( @holidays.elems > 0 && @holidays.grep( * ~~ $day.Str ) ) {
	    $day .= later( days => 1 );
	}


	$offset--;
    }

    $day.say;

}
