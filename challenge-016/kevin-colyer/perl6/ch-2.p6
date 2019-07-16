#!/usr/bin/perl6
use v6;

use Digest::SHA256::Native;
use Test;

# 16.2
# Write a script to validate a given bitcoin address. Most Bitcoin addresses are 34 characters. They consist of random digits and uppercase and lowercase letters, with the exception that the uppercase letter “O”, uppercase letter “I”, lowercase letter “l”, and the number “0” are never used to prevent visual ambiguity. A bitcoin address encodes 25 bytes. The last four bytes are a checksum check. They are the first four bytes of a double SHA-256 digest of the previous 21 bytes. For more information, please refer https://en.bitcoin.it/wiki/Address page. Here are some valid bitcoin addresses:
#   1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
#   3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

constant $b58chars = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';


#| Validates a bitcoin address
sub MAIN(Str $addr="1AGNa15ZQXAZUgFiqJ2i7Z2DPU2J6hW62i") {
    my  $byte =0;
    my $c=0;
    my @address=$addr.comb;
    my $chksum = buf8.allocate(4,0);
    my $bytes = buf8.allocate(25,0);
        for ^@address.elems -> $i {
            $c=index($b58chars,@address[$i]); # add next base 58 number to existing sum
            for (^$bytes).reverse -> $j {
                $c+=58 * $bytes[$j];
                $bytes[$j] = $c mod 256; # take lower byte
                $c=$c div 256; # take upper byte
            }
            say "Invalid: Address too long" and exit if $c>0;
        }
$chksum=$bytes.subbuf(*-4);
    my $double_sha256 = sha256(sha256($bytes.subbuf(0..20)));
    say "Invalid" and exit if $chksum !~~ $double_sha256.subbuf(^4);
    say "Valid";
};
