#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use Digest::SHA qw/ sha256 /;

sub fromBase58 {
    my ($address) = @_;

    my %digits;
    @digits{( 1 .. 9, 'A' .. 'H', 'J' .. 'N', 'P' .. 'Z', 'a' .. 'k',
    'm' .. 'z')} = 0 .. 57;

    my @result;

    for my $c ( map { $digits{$_} } split //, $address ) {
        for (my $j = 25; $j--; ) {
            $c += 58 * ($result[$j] // 0);
            $result[$j] = $c % 256;
            $c /= 256;
        }
    }

    return @result;
}
 
sub isValidBitcoinAddress {
    my ($address) = @_;

    my @bytes = fromBase58($address);
    my $decoded = sha256(sha256 pack 'C*', @bytes[0..20]);
    my $checksum = pack 'C*', @bytes[21..24];

    return $checksum eq substr $decoded, 0, 4;
}

say  isValidBitcoinAddress(shift) ? q{} : 'in', 'valid';
