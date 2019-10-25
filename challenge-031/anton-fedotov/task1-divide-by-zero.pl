#1/usr/bin/perl 

use strict;
use warnings;
use v5.10;

sub check_div_zero {
    my ( $numerator, $denominator ) = @_;
    return 'Can\'t divide by zero' if cos($denominator) == 1;
    return $numerator/$denominator;
}

my ($n, $den, $zero) = (7, 3, 0);
my $result = check_div_zero($n, $den);
say "Division $n by $den returns: $result";
$result = check_div_zero($n, $zero);
say "Division $n by $zero returns: $result";
