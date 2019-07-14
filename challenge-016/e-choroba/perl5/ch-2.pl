#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Digest::SHA qw(sha256);

my @b58 = grep /[^0IOl]/, 0 .. 9, 'A' .. 'Z', 'a' .. 'z';
my %b58 = map { $b58[$_] => $_ } 0 .. $#b58;
my @generator = (0x3b6a57b2, 0x26508e6d, 0x1ea119fa, 0x3d4233dd, 0x2a1462b3);

my %bech32 = qw(0 15  2 10  3 17  4 21  5 20  6 26  7 30  8  7
                9  5  a 29  c 24  d 13  e 25  f  9  g  8  h 23
                j 18  k 22  l 31  m 27  n 19  p  1  q  0  r  3
                s 16  t 11  u 28  v 12  w 14  x  6  y  4  z  2);

sub unbase58 {
    my ($in) = @_;
    my @out;
    for my $d (@b58{ split //, $_[0] }) {
        my $c = $d;
        my $j = 25;
        while ($j--) {
            $c += 58 * ($out[$j] // 0);
            $out[$j] = $c % 256;
            $c /= 256;
        }
    }
    return @out
}

sub check_bitcoin_address {
    my ($address) = @_;
    if ($address =~ /^[13]/) {
        return check_bitcoin_address_b58($address)
    } elsif ($address =~ /^(?:bc|tb)1/i) {
        return check_bitcoin_address_bech32(lc $address)
    }
    return
}

sub check_bitcoin_address_bech32 {
    my ($address) = @_;
    my ($human_readable, $data) = $address
        =~ /^(bc|tb)1([023456789acdefghjklmnpqrstuvwxyz]{7,})$/
    or return;

    my @data;
    for my $char(unpack 'C*', $data) {
        push @data, $bech32{chr $char} // -1;
    }

    return 1 == poly_mod(hrp_expand($human_readable), @data);
}

sub poly_mod {
    my @values = @_;
    my $chk = 1;
    for my $i (0 .. $#values) {
        my $top = $chk >> 25;
        $chk = ($chk & 0x1ffffff) << 5 ^ $values[$i];
        for (my $j = 0; $j < 5; $j++) {
            my $value = (($top >> $j) & 1) ? $generator[$j] : 0;
            $chk ^= $value;
        }
    }
    return $chk
}

sub hrp_expand {
    my ($hrp) = @_;
    my (@expand1, @expand2);
    for my $i (1 .. length $hrp) {
        my $o = ord substr $hrp, $i - 1, 1;
        push @expand1, $o >> 5;
        push @expand2, $o & 31;
    }
    return @expand1, 0, @expand2
}

sub check_bitcoin_address_b58 {
    my ($address) = @_;
    my @byte = unbase58 $address;
    return pack('C*', @byte[ 21 .. 24 ])
        eq substr sha256(sha256(pack 'C*', @byte[0..20])), 0, 4;
}

my @valid = qw( 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
                3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy
                bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq
                bc1qrp33g0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3qccfmv3
                tb1qw508d6qejxtdg4y5r3zarvary0c5xw7kxpjzsx
                tb1qrp33g0q5c5txsp9ARYSRX4K6ZDKFS4NCE4XJ0GDCCCEFVPYSXF3Q0SL5K7
);

my @invalid = qw( 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN3
                  bc1qar0srrs7xfkvy5l643lydnw9re59gtzzwf5mdq
                  bc1qrp33f0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3qccfmv3
                  tb1qw508d6qejytdg4y5r3zarvary0c5xw7kxpjzsx
                  tb1qrp33g0q5c5twsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3q0sl5k7
);

use Test::More;
plan tests => @valid + @invalid;

for (@valid) {
    ok check_bitcoin_address($_), "valid $_";
}
for (@invalid) {
    ok ! check_bitcoin_address($_), "invalid $_";
}
