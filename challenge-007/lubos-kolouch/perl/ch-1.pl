use strict;
use warnings;

# Function to calculate the sum of digits
sub sum_of_digits {
    my $number = shift;
    my $sum    = 0;
    while ( $number > 0 ) {
        $sum += $number % 10;
        $number = int( $number / 10 );
    }
    return $sum;
}

# Main program
for my $num ( 0 .. 50 ) {
    my $sum = sum_of_digits($num);
    if ( $sum > 0 && $num % $sum == 0 ) {
        print "$num\n";
    }
}
