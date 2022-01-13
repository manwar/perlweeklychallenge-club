#!perl.exe

use strict;
use warnings;
use Switch;
use 5.30.0;

### AUTHOR: Robert DiCicco
### DATE: 25-NOV-2021
### Challenge #140 Add Binary

my $str;

## Used to left fill number string
my %filler = (
    "0"  => "0000",
    "1"  => "000",
    "2"  => "00",
    "3"  => "0",
    "4"  => "",
    "5"  => "000",
    "6"  => "00",
    "7"  => "0",
    "8"  => "",
    "9"  => "000",
    "10" => "00",
    "11" => "0",
    "12" => "",
    "13" => "000",
    "14" => "00",
    "15" => "0",
    "16" => "",
);

sub fillout {
    my $inp   = 0;
    my $innum = shift;
    chomp;
    $inp = length($innum);

    return ( "$filler{$inp}" . "$innum" );
}

sub dec2bin {
    $str = unpack( "B32", pack( "N", $_[0] ) );
    $str =~ s/^0+(?=\d)//;    # otherwise you'll get leading zeros

    return $str;
}

sub bin2dec {
    return unpack( "N", pack( "B32", substr( "0" x 32 . shift, -32 ) ) );
}

my $final_string = "";

print("Input number: ");
my $first = <>;
$first = int($first);

print("Input number: ");
my $second = <>;
$second = int($second);

## Limit sum less than 1000
die "Sum of input values too large. Must be < 1000\n"
  if ( ( $first + $second ) > 999 );

my @inparr = ( $first, $second, $first + $second );

my $total_line = 0;
foreach (@inparr) {
    chomp;
    $total_line++;

    my $len = length($_);
    my @arr = split( //, $_ );
    my $cnv = dec2bin( $arr[0] );
    $cnv          = fillout($cnv);
    $final_string = $final_string . $cnv . " ";

    if ( $len > 1 ) {
        $cnv          = dec2bin( $arr[1] );
        $cnv          = fillout($cnv);
        $final_string = $final_string . $cnv . " ";
    }

    if ( $len > 2 ) {
        $cnv          = dec2bin( $arr[2] );
        $cnv          = fillout($cnv);
        $final_string = $final_string . $cnv . " ";
    }

    if ( $total_line == 3 ) {
        print("__________________________\n");
    }

    my $slen = length($final_string);
    switch ($slen) {
        case 15 { $final_string = $final_string }
        case 10 { $final_string = "0000 " . $final_string }
        case 5 { $final_string = "0000 0000 " . $final_string }
        else { die "Problem SLEN = $slen \n" }
    }

    print("$_ = $final_string\n");
    $final_string = "";
}
