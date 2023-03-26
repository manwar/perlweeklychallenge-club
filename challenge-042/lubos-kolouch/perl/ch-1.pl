use strict;
use warnings;
use Test::More;

# Convert a decimal number to octal
sub decimal_to_octal {
    my $decimal = shift;
    return sprintf( "%o", $decimal );
}

# Test the decimal to octal conversion function
is( decimal_to_octal(0),  '0',  '0 is converted to 0' );
is( decimal_to_octal(1),  '1',  '1 is converted to 1' );
is( decimal_to_octal(2),  '2',  '2 is converted to 2' );
is( decimal_to_octal(7),  '7',  '7 is converted to 7' );
is( decimal_to_octal(8),  '10', '8 is converted to 10' );
is( decimal_to_octal(50), '62', '50 is converted to 62' );

done_testing();
