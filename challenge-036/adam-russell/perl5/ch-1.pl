use strict;
use warnings;
##
# Write a program to validate Vehicle Identification Numbers (VINs).    
##
use boolean; 
use Readonly; 
Readonly::Hash my %CHAR_VALUES => (
    A => 1,
    B => 2,
    C => 3,
    D => 4,
    E => 5,
    F => 6,
    G => 7,
    H => 8,
    J => 1,
    K => 2,
    L => 3,
    M => 4,
    N => 5,
    P => 7,
    R => 9,
    S => 2,
    T => 3,
    U => 4,
    V => 5,
    W => 6,
    X => 7,
    Z => 9,
    1 => 1,
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    0 => 0, 
);
Readonly::Array my @WEIGHTS => (8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2);
Readonly::Array my @CHECK_DIGITS => (0 .. 9, "X"); 

sub is_valid{
    my ($vin) = @_;
    $vin = uc($vin);
    unless($vin =~ m/^[A-H J-N P R-Z 0-9]{9}[A-H J-N P R-T V-Y 1-9]{1}[A-H J-N P R-Z 0-9]{7}$/){
        return false; 
    }  
    else{
        my @vin = split(//, $vin); 
        my $checksum = 0;
        my @values = map { $CHAR_VALUES{$_} } @vin;  
        for(my $i = 0; $i < @values; $i++){
            $checksum = ($checksum + ($values[$i] * $WEIGHTS[$i]));  
        } 
        my $check_digit = $checksum % 11; 
        return true if $vin[8] eq $CHECK_DIGITS[$check_digit]; 
    } 
    return false; 
}

MAIN:{ 
    print is_valid($ARGV[0]); 
    print "\n";
}  
