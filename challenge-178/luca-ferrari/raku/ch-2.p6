#!raku

sub MAIN( Str $ts = '2022-08-01 10:30', Rat $duration = 4.0 ) {

    $ts ~~ /(\d ** 4) '-' (\d ** 2) '-' (\d ** 2) \s+ (\d ** 2) ':' (\d ** 2)/;

    my $when = DateTime.new: year => $/[0],
               month => $/[1],
               day => $/[2],
               hour => $/[3],
               minute => $/[4];

    my ($min_hour, $max_hour) = (9, 18);
    my @working_days = 1 .. 5;

    my $remaining_minutes = $duration * 60;

    while ( $remaining_minutes > 0 ) {


        if ( $min_hour > $when.hour > $max_hour
             || ( $when.hour == $max_hour && $when.minute >= 0 )
             || $when.day-of-week !~~ any( @working_days ) ) {
            # go to the next working day

            $when = $when.clone( hour => $min_hour, minute => 0 ).later( days => 1 );
            while ( $when.day-of-week !~~ any(@working_days) ) {
                $when = $when.later( days => 1 );
                }
        }
        else {
            # add one minute
            $when = $when.later( minutes => 1 );

            $remaining_minutes--;
        }

    }

    say $when;

}
