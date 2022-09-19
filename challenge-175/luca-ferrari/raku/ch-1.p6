#!raku

# Perl Weekly Challenge 175

sub MAIN( Int $year = 2022 ) {

    my @dates;

    for 1 .. 12 {
        my $day = Date.new( year => $year,
                            month => $_ ) # day automatically set to 1
                      .last-date-in-month;

        $day .= pred  while ( $day.day-of-week != 7 );
        @dates.push: $day;
    }

    @dates.join( "\n" ).say;
}
