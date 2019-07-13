#!/usr/bin/env perl6
use v6;

# This only supports type 1 & 5 bitcoin addresses on the main net.
# It does not support test net addresses or Bech32 addresses.

use Digest::SHA256::Native;

multi sub MAIN(Bool :$test where * == True) {
    use Test;

    my @tests =
        '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'  => True,
        '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN21' => False, # Too long
        '1BvBMSEYstWetqTFn5Au4m4GFg0xJaNVN2'  => False, # Invalid char
        '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVM2'  => False, # Bad checksum
        '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'  => True,
        '1111111111111111111114oLvT2'         => True,
        '111111111111111111114oLvT2'          => False, # Too short 
        '11111111111111111111114oLvT2'        => False, # Too long 
    ;

    for @tests -> $test {
        is validate($test.key), $test.value, "{$test.key} {$test.value}";
    }

    done-testing;
}

multi sub MAIN(Str:D $addr) {
    say validate($addr);
}

sub validate(Str:D $addr --> Bool) {
    # Is it valid base-58?
    my $val = base58-decode($addr);
    return False unless $val.defined;

    # Format we expect:
    #   0x00 <20 bytes - hash> <4 byte checksum> # Is it too big (>25 bytes decoded)?
    return False if $val > 2²⁰⁰;    # Too big

    # Is the first digit a 1 or 5? That's the only type we support.
    my $ver = $val +& ( 0xff +< ( 24 * 8 ) ) +> ( 24 * 8 );
    return False if $ver ≠ 0|5;     # Unknown version

    # Is it in cannonical format - I.E. the standard format it would be
    # encoded as?
    return False unless $addr eq base58-encode($val, 25);

    # Does the checksum match?
    my $buf = int-to-buf8($val, 25); # Version zero should be 25 bytes longkkk
    my $sha = sha256(sha256($buf.subbuf(0, 21)));
    return False unless $sha.subbuf(0,4) ~~ $buf.subbuf(21,4);

    return True;
}

sub base58-decode(Str:D $txt --> UInt) {
    # Build hash of character values - hash key is the character to
    # decode, the value is it's value.
    state %chars =
        Hash.new('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'.comb Z 0..57);

    my $val = 0;
    for $txt.comb -> $c {
        return UInt unless %chars{$c}:exists;
        $val *= 58;
        $val += %chars{$c};
    }
    return $val;
}

sub base58-encode(UInt:D $int is copy, UInt:D $bytes --> Str:D) {
    # Build hash of character values - hash key is the value of the
    # digit, hash value is the character to encode
    state %vals =
        Hash.new(0..57 Z '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'.comb);

    my Str:D $zeros = '';

    # Handle leading zero bytes
    my $buf = int-to-buf8($int, $bytes);
    for $buf.list -> $byte {
        if $byte == 0 { $zeros ~= '1'; } # Leading zero compression;
        if $byte  ≠ 0 { last; }
    }

    my $encoded = '';
    while $int > 0 {
        $encoded = %vals{$int % 58} ~ $encoded;
        $int = ($int / 58).floor;
    }

    return "$zeros$encoded";
}

sub int-to-buf8(UInt:D $int, UInt:D $bytes --> buf8:D) {
    my $buf8 = buf8.new;

    for ^($bytes) -> $i {
        my $byte = $int +> (8 * (($bytes-1) - $i)) +& 0xff;
        $buf8.push: $byte;
    }

    return $buf8;
}
