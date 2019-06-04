# Write a script to encode/decode Roman numerals.
# For example, given Roman numeral CCXLVI, it should return 246.
# Similarly, for decimal number 39, it should return XXXIX.
# Checkout wikipedia page for more informaiton.

use strict;
use warnings;
use v5.10;

# %patterns are all patterns you can find in roman numbers
# order of patterns are important for matching, as for instance
# in a roman to arabic conversion, we should check for a match
# with 'MMM' before checking a match with 'M'
# descending order by values of the hash should be ok
my %patterns = (
    MMM  => 3000,
    MM   => 2000,
    M    => 1000,
    CM   => 900,
    DCCC => 800,
    DCC  => 700,
    DC   => 600,
    D    => 500,
    CD   => 400,
    CCC  => 300,
    CC   => 200,
    C    => 100,
    XC   => 90,
    LXXX => 80,
    LXX  => 70,
    LX   => 60,
    L    => 50,
    XL   => 40,
    XXX  => 30,
    XX   => 20,
    X    => 10,
    IX   => 9,
    VIII => 8,
    VII  => 7,
    VI   => 6,
    V    => 5,
    IV   => 4,
    III  => 3,
    II   => 2,
    I    => 1
);

# we begin reading the value, and deciding if it will be a forward or reverse traduction

my $in = shift;

if ( !$in ) { die "Usage: perl $0 <number to transform>" }    # no number or 0
elsif ( $in =~ /^\d+$/ ) {

    # arabic to roman case
    die "Fatal, number to convert to roman is greater than 3999" if $in > 3999;

    # we now separate on digits
    my ( $th, $hunds, $tens, $ones ) = split '', sprintf( '%04u', $in );

    # we need the opossite hash now (value => pattern)
    my %rps = reverse %patterns;

    # now we convert digit by digit
    my $res = '';
    $res .= $rps{ $th * 1000 }   if $th;
    $res .= $rps{ $hunds * 100 } if $hunds;
    $res .= $rps{ $tens * 10 }   if $tens;
    $res .= $rps{$ones}          if $ones;
    say "$in converted is: $res";
}
elsif ( $in =~ /^[ivxlcdm]+$/i ) {

    # roman to arabic case
    my $ucin  = uc $in;
    my $value = 0;

# now we start matching from left to right against all patterns, taking away matched part,
# until we get an empty string
# Note 1: order of matching is important, has to be descendant in value of pattern
# Note 2: only one match for pattern is allowed (no restart after each match)
    for my $p ( sort { $patterns{$b} <=> $patterns{$a} } keys %patterns ) {
        next unless $ucin =~ s/^$p//;
        $value += $patterns{$p};
    }
    if ($ucin) {
        die "Fatal error, $ucin remaining after trying to convert $in";
    }
    else { say "$in converted is: $value" }
}
else { die "Fatal: $in doesn't seem to be arabic nor roman" }
