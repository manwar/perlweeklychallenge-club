#!/r/bin/perl
use strict;
use warnings;

# with this script you can add 2 binary numbers and get their sum as binary number
# https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK1

# get input
print "decimal number a: ";
my $a = <STDIN>;
chomp $a;
my $a_binary = decimal_to_binary ( $a );
printf ( "binary number a: %i\n", $a_binary );

# convert dec to bin
sub decimal_to_binary {
    my ( $decimal ) = @_;

    return _decimal_to_binary ( 0, $decimal );
}

sub _decimal_to_binary {
    my ( $power, $decimal_number, $binary_quantum ) = @_;

    if ( $decimal_number == 0 ) {
        return 0;
    }

    if ( $decimal_number == 2**$power ) {
        $binary_quantum += 10**$power;
        return $binary_quantum; 
    }

    if ( $decimal_number > 2**$power && $decimal_number < 2**( $power +1 ) ) {
        $binary_quantum += 10**$power;
        $decimal_number -= 2**$power;
        $power = 0;
        return _decimal_to_binary ( $power, $decimal_number, $binary_quantum );
    }

    $power++;
    return _decimal_to_binary ( $power, $decimal_number, $binary_quantum );
}