#!/usr/bin/env perl6

subset ValidVinStr of Str
    where m/^ <[A..Z 0..9] - [IOQ]> ** 9 <[A..Z 0..9] - [IOQUZ0]> <[A..Z 0..9] - [IOQ]> ** 7 $/;

#| Validate a North American VIN
sub MAIN (
    ValidVinStr $vin #= VIN to check
) {
    my %transliterator = ( ( "A".."Z" ) Z=> ( |(1..9),|(1..9),|(2..9) ) );

    my @combed = $vin.comb();
    my $check = @combed[8];
    my $calc-check = ( [+] (@combed[|(0..7),|(9..16)].map( { %transliterator{$_} // $_ } )) Z* (|(8...2),|(10...2)) ) % 11;
    $calc-check = "X" if $calc-check == 10;
    say $calc-check ~~ $check ?? "Valid VIN $vin" !! "Invalid VIN $vin";
}
