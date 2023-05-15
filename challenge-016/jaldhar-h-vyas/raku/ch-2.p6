#!/usr/bin/perl6
use Digest::SHA256::Native;

sub fromBase58($address) {
    my %digits = ( 1 .. 9, 'A' .. 'H', 'J' .. 'N', 'P' .. 'Z', 'a' .. 'k',
        'm' .. 'z').flat Z=> 0 .. 57;

    my @result;

    for $address.comb.map({ %digits{$_} }) -> $digit {
        my $c = $digit;
        for 24 ... 0 -> $j  {
            $c += (58 * (@result[$j] // 0));
            @result[$j] = $c % 256;
            $c div= 256;
        }
    }

    return @result;
}

sub isValidBitcoinAddress($address) {
    my @bytes = fromBase58($address);
    my $decoded = sha256(sha256(Blob.new(@bytes[0..20])));
    my $checksum = Blob.new(@bytes[21..24]);
    return $checksum eqv $decoded.subbuf(0, 4);
}

sub MAIN (
    $address    #= a bitcoin address to validate.
) {
    say isValidBitcoinAddress($address) ?? q{}  !! 'in', 'valid';
}