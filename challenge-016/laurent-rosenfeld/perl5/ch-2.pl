#!/usr/bin/perl
use strict;
use warnings;
use Digest::SHA qw/sha256/;
use Test::More tests => 4;

my @base58 = split //,
    "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
    # https://en.wikipedia.org/wiki/Base58
my %base58 = map { $base58[$_] , $_} 0 .. 57;

sub base58_to_bytes {
    use integer;
    my $input = shift;
    my @out;
    for my $letter ( split //, $input ) {
        $_ *= 58 for @out; # new letter, multiply previous values by the base
        $out[0] += $base58{$letter};
        for my $index ( 0 .. $#out ) {
            my $val = $out[$index];
            if ($val > 255) {
                $out[$index] = $val % 256;  # normalize current byte
                $out[$index + 1] += $val / 256; # carry over to next
            }
        }
    }
    $out[$_] //= 0 for 0 .. 24;  # padding empty slots
    return reverse @out;
}
sub check_address {
    my $address = shift;
    die "Forbidden character" if $address =~ /[O0lI]/;
    my @byte = base58_to_bytes $address;
    return 0 unless
        (pack 'C*', @byte[21..24]) eq
        substr sha256(sha256 pack 'C*', @byte[0..20]), 0, 4;
    return 1;
}

is check_address("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"), 1, "Correct Address 1";
is check_address("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVw2"), 0, "Incorrect Address 1";
is check_address("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), 1, "Correct Address 2";
is check_address("3J99t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), 0, "Incorrect Address 2";
