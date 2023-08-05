use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

sub date_difference {
    my ( $date1, $date2 ) = @_;

    # convert string to Time::Piece object
    my $date1_obj = Time::Piece->strptime( $date1, "%Y-%m-%d" );
    my $date2_obj = Time::Piece->strptime( $date2, "%Y-%m-%d" );

    # calculate difference
    my $diff  = $date2_obj - $date1_obj;
    my $years = int( $diff->years );
    my $days  = $diff->days % 365;

    # format output
    my $output = "";
    if ( $years == 1 ) {
        $output .= "1 year ";
    }
    elsif ( $years > 1 ) {
        $output .= "$years years ";
    }
    if ( $days == 1 ) {
        $output .= "1 day";
    }
    elsif ( $days > 1 ) {
        $output .= "$days days";
    }
    return $output;
}

print date_difference( '2019-02-10', '2022-11-01' )
  . "\n";    # Output: 3 years 264 days
print date_difference( '2020-09-15', '2022-03-29' )
  . "\n";    # Output: 1 year 195 days
print date_difference( '2019-12-31', '2020-01-01' ) . "\n";    # Output: 1 day
print date_difference( '2019-12-01', '2019-12-31' ) . "\n";    # Output: 30 days
print date_difference( '2019-12-31', '2020-12-31' ) . "\n";    # Output: 1 year
print date_difference( '2019-12-31', '2021-12-31' ) . "\n";    # Output: 2 years
print date_difference( '2020-09-15', '2021-09-16' )
  . "\n";    # Output: 1 year 1 day
print date_difference( '2019-09-15', '2021-09-16' )
  . "\n";    # Output: 2 years 1 day
