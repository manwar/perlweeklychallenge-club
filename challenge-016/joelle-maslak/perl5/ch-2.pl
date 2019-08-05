#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use bigint;

use Digest::SHA qw(sha256);

die("Please provide bitcoint address as argument") unless scalar(@ARGV) eq 1;

if ($ARGV[0] eq '--test') {
    test();
} else {
    say validate($ARGV[0]) ? 'True' : 'False';
}

sub test() {
    my @tests = (
        ['1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'   => 1 ],
        ['1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN211' => undef ], # Too long
        ['1BvBMSEYstWetqTFn5Au4m4GFg0xJaNVN2'   => undef ], # Invalid char
        ['1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVM2'   => undef ], # Bad checksum
        ['3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'   => 1 ],
        ['1111111111111111111114oLvT2'          => 1 ],
        ['111111111111111111114oLvT2'           => undef ], # Too short
        ['11111111111111111111114oLvT2'         => undef ], # Too long
    );
    
    use Test2::V0;

    for my $test (@tests) {
        is validate($test->[0]), $test->[1], $test->[0] . ' ' . ($test->[1] ? 'True' : 'False');
    }


    done_testing;

}

sub validate($addr) {
    # Is it valid base-58?
    my $val = base58_decode($addr);
    return if !defined($val);

    # Format we expect:
    #   <version> <20 bytes> <4 byte checksum>
    return if $val >= (2**200);

    # Is the first byte a 1 or a 5? Those are the only types we support.
    my $ver = $val / (2**(24*8)) & 0xff;
    return if ($ver != 0 and $ver != 5);

    # Is it in cannonical format - I.E. the standard format it would be
    # encoded as?
    return unless $addr eq base58_encode($val, 25);

    # Does the checksum match?
    my (@buf) = int_to_buf($val, 25)->@*;
    my $sha = sha256(sha256(join '', @buf[0..20]));
    return unless substr($sha, 0, 4) eq join('',@buf[21..24]);

    return 1;
}

sub base58_decode($txt) {
    state $chars;
    if (!defined($chars)) {
        $chars = {};

        my (@txt) = split //, '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
        for (my $i=0; $i<58; $i++) {
                $chars->{$txt[$i]} = $i;
        }
    }

    my $val = 0;
    for my $c (split //, $txt) {
        return unless exists $chars->{$c};
        $val = $val * 58 + $chars->{$c};
    }

    return $val;
}

sub base58_encode($int, $bytes) {
    state $vals;
    if (!defined($vals)) {
        $vals = {};

        my (@txt) = split //, '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
        for (my $i=0; $i<58; $i++) {
                $vals->{$i} = $txt[$i];
        }
    }

    # Handle leading zero bytes
    my $zeros = '';
    my $buf = int_to_buf($int, $bytes);
    for my $byte (@$buf) {
        if (ord($byte) == 0) { $zeros .= '1'; } # Leading zero comparison
        if (ord($byte) != 0) { last; }
    }

    my $encoded = '';
    while ($int > 0) {
        $encoded = $vals->{$int % 58} . $encoded;
        $int = $int / 58;
    }
    
    return "$zeros$encoded";
}

sub int_to_buf($int, $bytes) {
    my $buf = [];

    for (my $i=0; $i<$bytes; $i++) {
        my $byte = ( $int / (2**(8 * (($bytes-1) - $i)) )) % 256;
        push @$buf, chr($byte);
    }

    return $buf;
}
