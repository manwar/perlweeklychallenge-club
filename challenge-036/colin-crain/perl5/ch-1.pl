#! /opt/local/bin/perl
#
#       vin_verify.pl
#
#       PWC 36 - TASK #1
#       Write a program to validate given Vehicle Identification Number (VIN).
#
#       method: well to start, there isn't really any way to validate a VIN,
#           not really, worldwide. But there are a variety of qualities to
#           the number that we can check, and, if the car is to be sold in
#           North America, or China apparantly, it will have a check digit
#           placed within it. However if the vehicle is built in and
#           specially imported from Europe the check digit may not be
#           encoded.

#           What we can check is that the VIN has 17 alphanumeric digits, and
#           does not contain the letters O, I, or Q. Additionally the model year
#           code cannot contain 0, U or Z. The checksum digit should be valid
#           for all vehicles manufactured in China or North America, so for
#           those vehicles the first digit will be in the range 1-5, for North
#           America, or L, for China. Vehicles made, for instance, in Malaysia
#           for sale in China would have the checksum, but this cannot be
#           assumed for every vehicle made there, so unless the manufacturer's
#           code indicates as referenced above the test will be bypassed with
#           a note.
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



# use warnings;
use strict;
# use diagnostics;
use feature ":5.26";

## ## ## ## ## MAIN

if ( scalar @ARGV == 0 ) {say "--enter your VIN-- \nusage: ./vin_verify.pl [VIN]"; exit;};

my $vin = uc(shift @ARGV);

say "result of 1 indicates failure:";
say "length 17 chars     ", length17( $vin );
say "alphanumeric        ", alphanumeric( $vin );
say "model year encoding ", model_year_encoding( $vin );
say "checksum digit      ", na_checksum( $vin );


## ## ## ## ## SUBS

sub length17 {
## is length 17 alpha chars?
    return( length $_[0] == 17 ? 'VALID' : 'FALSE');
}

sub alphanumeric {
## does not include I,O,Q
    my $vin = shift;
    return( $vin =~ /[^A-H J-N P R-Z 0-9]/xx ) ?  'FALSE' : 'VALID';

}
sub model_year_encoding {
## cannot include any of I,O,Q,U,Z,0
    my $year = [split //, shift]->[9];
    return( $year =~ /[^A-H J-N P RST VW 1-9]/xx ) ?  'FALSE' : 'VALID';
}

sub na_checksum {
## only valid for North America and China, returns invalid test for rest of world
    my @vin = split //, shift;
    return 'NOT NORTH AMERICA OR CHINA' unless ($vin[0] =~ /[1-5L]/);

    my $check = $vin[8];
    my %vals = (    A =>  1, B =>  2, C =>  3, D =>  4, E =>  5, F =>  6, G =>  7, H =>  8,
            J =>  1, K =>  2, L =>  3, M =>  4, N =>  5, P =>  7, R =>  9,
            S =>  2, T =>  3, U =>  4, V =>  5, W =>  6, X =>  7, Y =>  8, Z =>  9 );
    @vals{ 1..9 } = ( 1..9 );
    my @weights = (8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2);

    my $sum = 0;
    for my $idx( 0..16 ) {
        $sum += $vals{ $vin[$idx] } * $weights[ $idx ];
    }
    $vin[8] eq 'X' and $vin[8] = 10;        ## low precedence 'and' will short-circuit unless check digit is 'X'
    return ( $sum % 11 == $vin[8] ? 'VALID' : 'FALSE' );
}
