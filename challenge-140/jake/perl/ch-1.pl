#!/r/bin/perl
use strict;
use warnings;

# with this script you can add 2 binary numbers and get their sum as binary number
# https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK1

# get input of 2 binary numbers

print "binary number a: ";
my $binary_input_a = <STDIN>;
print "binary number b: ";
my $binary_input_b = <STDIN>;
chomp ( $binary_input_a, $binary_input_b );


# convert binaries to decimals

my $a_decimal = binary_to_decimal ( $binary_input_a );
my $b_decimal = binary_to_decimal ( $binary_input_b );


# perform regular addition on decimals

my $result_decimal = $a_decimal + $b_decimal;


# convert decimal results to binary

my $result_binary = decimal_to_binary ( $result_decimal );
print "$result_binary\n";

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

sub binary_to_decimal {
    my ( $binary ) = @_;

    return _binary_to_decimal ( $binary, 0, 0 );
}

sub _binary_to_decimal {
    my ( $binary_number, $power, $acc, $tail ) = @_;

    return $acc if $binary_number eq '';

    $tail = chop ($binary_number);

    if ( $tail == 1 ) {
        $acc += 2**$power;
        $power++;
        return _binary_to_decimal ( $binary_number, $power, $acc );
    }

    if ( $tail == 0 ) {
        $power++;
        return _binary_to_decimal ( $binary_number, $power, $acc );
    }
}