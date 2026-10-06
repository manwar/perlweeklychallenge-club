#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 016-2,
written by Robbie Hatley on Tue Oct 06, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 016-2: Validating Bitcoin Addresses
Write a script to validate a given bitcoin address. Most Bitcoin
addresses are 34 characters. They consist of random digits and
uppercase and lowercase letters, with the exception that the
uppercase letter “O”, uppercase letter “I”, lowercase letter “l”,
and the number “0” are never used to prevent visual ambiguity.
A bitcoin address encodes 25 bytes. The last four bytes are
a checksum check. They are the first four bytes of a double
SHA-256 digest of the previous 21 bytes. For more information,
see here: https://en.bitcoin.it/wiki/Address
Here are some valid bitcoin addresses:
1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

This was rather elaborate, involving conversion from base 58 to base 16, custom collation sequences,
packing, unpacking, and two iterations of SHA-256 hashing.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a bitcoin address. For example:

./ch-2.pl '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2' '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use Math::BigInt 'lib' => 'GMP';
   Math::BigInt->accuracy(500);
   use bigint;
   use Digest::SHA qw( sha256 );

   my $cs02='01';
   my $cs10='0123456789';
   my $cs16='0123456789ABCDEF';
   my $cs58='123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

   # Convert a number from one base to another:
   sub base ( $base1 , $cs1 , $base2 , $cs2 , $input ) {
      Math::BigInt->from_base($input, $base1, $cs1)->to_base($base2, $cs2);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @addresses = @ARGV ? @ARGV :
(
   '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2',
   '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy',
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $address (@addresses) {
   say '';

   # Get hexadecimal value of base-58 string:
   my $addr16 = base(58, $cs58, 16, $cs16, $address);
   $addr16 = '0' x (50 - length($addr16)) . $addr16;

   # First 42 nybbles of $addr16 are the data:
   my $data16 = substr($addr16, 0, 42);

   # Last 8 nybbles of $addr16 are the embedded checksum:
   my $embedded16 = substr($addr16, -8, 8);

   # Get "double-SHA-256 hash" of hexadecimal of data:
   my $hash = sha256(sha256(pack 'H*', $data16));

   # Get first 4 bytes of hash:
   my $first4 = substr($hash,0,4);

   # Get hexadecimal version of first 4 bytes of hash:
   my $hash16 = uc unpack 'H*', $first4;

   # Announce results:
   say "Raw bitcoin address = $address";
   say "Hex bitcoin address = $addr16";
   say "Hex bitcoin data    = $data16";
   say "Hex embedded   hash = $embedded16";
   say "Hex calculated hash = $hash16";
}
