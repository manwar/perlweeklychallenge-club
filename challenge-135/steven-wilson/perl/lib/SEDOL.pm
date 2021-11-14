package SEDOL 0.001;
use strict;
use warnings;
use parent qw/ Exporter /;

our @EXPORT = qw/ validate_sedol /;

sub validate_sedol {
    my $input = shift;
    length $input == 7 or die "Invalid SEDOL number, not correct length\n";
    my $code  = substr $input, 0, 6;
    my $check = substr $input, 6, 1;
    $check =~ /[0-9]/ or die "Invalid SEDOL number, invalid check digit\n";
    $check == get_sedol_check_digit($code) ? return 1 : return 0; 
}

sub get_sedol_check_digit {
    my $code   = shift;
    my @weight = qw/ 1 3 1 7 3 9 1 /;
    $code =~ /[0-9A-Z]{6}/ or die "Invalid SEDOL number, invalid character\n";
    my @code = split //, $code;
    my $sum  = 0;
    for ( my $i = 0; $i < 6; $i++ ) {
        if ( ord( $code[$i] ) < 58 ) {
            $sum += ( $code[$i] * $weight[$i] );
        }
        else {
            $sum += ( ( ord( $code[$i] ) - 64 + 9 ) * $weight[$i] );
        }
    }
    return ( ( 10 - ( $sum % 10 ) ) % 10 );
}

1;
