#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-036/
# Task #1
# Write a program to validate given Vehicle Identification Number (VIN).
# For more information, please checkout wikipedia.
# https://en.wikipedia.org/wiki/Vehicle_identification_number

use strict;
use warnings;

die "USAGE: $0 <VIN>\n\nExample: $0 1M8GDM9AXKP042788\n" if @ARGV != 1;

my $vin = uc $ARGV[0];

# does not include the letters O (o), I (i), and Q (q)
print 'character validation: ';
validate( $vin =~ /[A-HJ-NPR-Z0-9]+/ );

# formed by 17 character
print 'length validation: ';
validate( $vin =~ /^(\w{3})(\w{6})(\w{8})$/ );
my ($wmi,$vds,$vis) = ($1, $2, $3);

# check-digit validation is used in the United States and Canada
if ( (substr $wmi,0,1) =~ /^[1245]/ ){
    print 'check-digit validation (United States and Canada): ';
    my $check = substr $vds,-1;
    validate( $check eq check_digit($vin) );
}

# U and Z and the digit 0 are not used for the model year code
print 'model year validation: ';
my $year = substr $vis,0,1;
validate( $year !~ /[UZ0]/ );

# in North America, the last five digits must be numeric
if ( (substr $wmi,0,1) =~ /^[1-5]/ ){
    print 'numeric serial validation (North America): ';
    my $serial = substr $vis,-5;
    validate( $serial =~ /\d{5}/ );
}

print "VIN $vin is valid\n";
exit 0;


sub check_digit {
    my $vin = shift;

    my $sum = 0;
    for my $i (0 .. length($vin)-1) {
        $sum += value(substr $vin,$i,1) * weight($i+1);
    }

    my $cd = $sum % 11;
    $cd = 'X' if $cd == 10;
    return $cd;
}

sub value {
    my $chr = shift;

    CORE::state $trans_key = {
        A=> 1, B=> 2, C=> 3, D=> 4, E=> 5, F=> 6, G=> 7, H=> 8,
        J=> 1, K=> 2, L=> 3, M=> 4, N=> 5,        P=> 7,        R=> 9,
               S=> 2, T=> 3, U=> 4, V=> 5, W=> 6, X=> 7, Y=> 8, Z=> 9,
    };

    return $chr if $chr =~ /\d/;
    return $trans_key->{$chr};
}


sub weight {
    my $pos = shift;
    return 10 if $pos == 8;
    return 0  if $pos == 9;
    return $pos > 9 ? 19-$pos : 9-$pos;

}

sub validate {
    my $bool = shift;
    if ($bool) { print "OK\n" }
    else       { print "failed\n"; exit 1;}
}

__END__

./ch-1.pl 1M8GDM9AXKP042788
character validation: OK
length validation: OK
check-digit validation (United States and Canada): OK
model year validation: OK
numeric serial validation (North America): OK
VIN 1M8GDM9AXKP042788 is valid

./ch-1.pl 1M8GDM9A6KP042788
character validation: OK
length validation: OK
check-digit validation (United States and Canada): failed

./ch-1.pl KLATF08Y1VB363636
character validation: OK
length validation: OK
model year validation: OK
VIN KLATF08Y1VB363636 is valid

./ch-1.pl KLATF08Y10B363636
character validation: OK
length validation: OK
model year validation: OK
VIN KLATF08Y1VB363636 is valid

./ch-1.pl KLATF08Y10B363636
character validation: OK
length validation: OK
model year validation: failed
