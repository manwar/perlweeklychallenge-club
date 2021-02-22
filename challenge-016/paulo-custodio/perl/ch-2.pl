#!/usr/bin/perl

# Challenge 016
#
# Task #2
# Write a script to validate a given bitcoin address. Most Bitcoin addresses
# are 34 characters. They consist of random digits and uppercase and lowercase
# letters, with the exception that the uppercase letter “O”, uppercase letter “I”,
# lowercase letter “l”, and the number “0” are never used to prevent visual
# ambiguity. A bitcoin address encodes 25 bytes. The last four bytes are a
# checksum check. They are the first four bytes of a double SHA-256 digest
# of the previous 21 bytes. For more information, please refer wiki page.
# Here are some valid bitcoin addresses:
#
#     1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
#     3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

use strict;
use warnings;
use 5.030;
use Crypt::Digest::SHA256 'sha256';

use constant BASE58 => 58;
use constant B58_DIGITS =>  "123456789".
                            "ABCDEFGHJKLMNPQRSTUVWXYZ".
                            "abcdefghijkmnopqrstuvwxyz";
use constant BTC_LENGTH => 25;
use constant CHECKSUM_LENGTH => 4;

# map b58 characters to digit value
my %base58_digit;
my $digit = 0;
for (split //, B58_DIGITS) { $base58_digit{$_} = $digit++; }
(BASE58==$digit) or die;

sub decode_b58 {
    my($str) = @_;
    my @bytes = (0) x BTC_LENGTH;   # will hold result of decoding

    # get each digit, multiply result by base and add digit
    for my $digit (split //, $str) {
        defined $base58_digit{$digit} or die "invalid digit: $digit";
        $_ *= BASE58 for @bytes;
        $bytes[-1] += $base58_digit{$digit};

        # carry over values > 256 to higher bytes
        my $carry = 0;
        for (reverse @bytes) {
            # add previous carry
            $_ += $carry;
            $carry = 0;

            # set new carry if overflow
            if ($_ > 0xff) {
                $carry = $_ >> 8;
                $_ &= 0xff;
            }
        }
        ($carry==0) or die "result more than ".BTC_LENGTH." bytes";
    }

    return pack("C*", @bytes);
}

# check if address is valid
sub btc_address_valid {
    my($str) = @_;

    # check address prefix
    return unless $str =~ /^(1|3|bc1)/;

    # decode 25-byte address
    my $addr = eval {decode_b58($str)};
    return unless defined $addr;

    # check checksum
    my $template = "a".(BTC_LENGTH - CHECKSUM_LENGTH)." a".CHECKSUM_LENGTH;
    my($vh160, $checksum) = unpack($template, $addr);
    my $hash = unpack("a4", sha256(sha256($vh160)));

    return ($hash eq $checksum);
}

say btc_address_valid(shift) ? 1 : 0;
