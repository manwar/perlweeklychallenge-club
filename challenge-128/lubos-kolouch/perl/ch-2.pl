use strict;
use warnings;

sub min_platforms {
    my ( @arrivals, @departures ) = @_;

    @arrivals   = sort @arrivals;
    @departures = sort @departures;

    my $platforms = 1;
    my $result    = 1;
    my $i         = 1;
    my $j         = 0;

    while ( $i < scalar @arrivals and $j < scalar @departures ) {
        if ( $arrivals[$i] <= $departures[$j] ) {
            $platforms++;
            $i++;
        }
        elsif ( $arrivals[$i] > $departures[$j] ) {
            $platforms--;
            $j++;
        }

        if ( $platforms > $result ) {
            $result = $platforms;
        }
    }

    return $result;
}

my @arrivals   = ( "10:20", "11:00", "11:10", "12:20", "16:20", "19:00" );
my @departures = ( "10:30", "13:20", "12:40", "12:50", "20:20", "21:20" );

print min_platforms( @arrivals, @departures ), "\n";
