#!/usr/bin/env perl
#
# Create script to implement Chaocipher. Please checkout wiki page for more
# information.
#
# (https://en.wikipedia.org/wiki/Chaocipher).
# (http://www.mountainvistasoft.com/chaocipher/ActualChaocipher/Chaocipher-Revealed-Algorithm.pdf).
################################################################################

use strict;
use warnings;

sub set_zenith {
    my ($alphabet, $character) = @_;
    my $idx = index($alphabet, $character);
    return substr($alphabet, $idx) . substr($alphabet, 0, $idx);
}

sub rotate {
    my $alphabet = shift;
    return substr($alphabet, 1) . substr($alphabet, 0, 1);
}

sub permute_left {
    my ($alphabet, $character) = @_;
    $alphabet = set_zenith($alphabet, $character);
    my $extracted = substr($alphabet, 1, 1);
    substr($alphabet, 1, 13) = rotate(substr($alphabet, 1, 13));
    return $alphabet;
}

sub permute_right {
    my ($alphabet, $character) = @_;
    $alphabet = rotate(set_zenith($alphabet, $character));
    my $extracted = substr($alphabet, 1, 1);
    substr($alphabet, 2, 12) = rotate(substr($alphabet, 2, 12));
    return $alphabet;
}

sub encrypt {
    my ($text, $left, $right) = @_;
    foreach my $index (0 .. length($text)-1) {
        my $plain_char = substr($text, $index, 1);
        my $cipher_char = substr($left, index($right, $plain_char), 1);
        substr($text, $index, 1) = $cipher_char;
        $left = permute_left($left, $cipher_char);
        $right = permute_right($right, $plain_char);
    }
    return $text;
}

sub decrypt {
    my ($text, $left, $right) = @_;
    foreach my $index (0 .. length($text)-1) {
        my $cipher_char = substr($text, $index, 1);
        my $plain_char = substr($right, index($left, $cipher_char), 1);
        substr($text, $index, 1) = $plain_char;
        $left = permute_left($left, $cipher_char);
        $right = permute_right($right, $plain_char);
    }
    return $text;
}

@ARGV == 3 or die "Usage: $0 <left_alpha> <right_alpha> <text>\n";
my ($left, $right, $text) = @ARGV;

my $cipher = encrypt($text, $left, $right);
print "Encrypted: '$cipher'\n";

my $plain = decrypt($cipher, $left, $right);
print "Decrypted: '$plain'\n";
