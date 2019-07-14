#!/usr/bin/perl

# Challenge 2: "Write a script to validate a given bitcoin address. Most
# Bitcoin addresses are 34 characters. They consist of random digits and
# uppercase and lowercase letters, with the exception that the uppercase
# letter O, uppercase letter I, lowercase letter l, and the number 0 are
# never used to prevent visual ambiguity. A bitcoin address encodes 25 bytes.
# The last four bytes are a checksum check. They are the first four bytes of
# a double SHA-256 digest of the previous 21 bytes. For more information,
# please refer to https://en.bitcoin.it/wiki/Address. Here
# are some valid bitcoin addresses:
# 
# 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
# 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy
# "
# 
# My notes:
# 
# After reading several wiki pages, I think this (badly explained) question
# means: decode type 1 or type 3 (not type bc1) Bitcoin addresses, which are
# a base58check encoding of a 25 byte sequence, which itself comprises a 21
# byte payload sequence followed by a 4-byte truncated sha256(sha256(payload)).
# 
# base58check itself is described here:
#    https://en.bitcoin.it/wiki/Base58Check_encoding
#
# However, there's some froody leading-zeroes shit, and the only really clear
# specification of the whole process is a reference decoder implementation:
#   http://lenschulwitz.com/b58/base58perl.txt
# which is written in Perl 5!  so if the only way to understand exactly what
# problem we're being asked to solve is to see a solution, in Perl 5, then
# this seems like a completely pointless question.  So I took "Len
# Schulwitz's" code above, and adapted it, which means that I didn't solve
# this problem, in any real sense, myself!

use strict;
use warnings;
use Function::Parameters;
use Digest::SHA qw(sha256);
use Data::Dumper;


# The base58 characters used by Bitcoin.
my @b58 = qw{1 2 3 4 5 6 7 8 9 A B C D E F G H J K L M N P Q R S T U V W X Y Z
 a b c d e f g h i j k m n o p q r s t u v w x y z};

# Used to decode base58 encoded bitcoin addresses
my %b58 = map { $b58[$_] => $_ } 0 .. 57;


#
# my( $valid, @decoded_bytes ) = unbase58( $address );
#	Decodes a Base58 encoded $address into an array of bytes,
#	and returns (1, @decoded_bytes) if it's valid, or (0, message) if not.
#       Code from http://lenschulwitz.com/b58/base58perl.txt
#
fun unbase58( $input )
{
        return ( 0, "Not valid Base58 string!\n" ) unless
		$input =~ /^[1-9A-HJ-NP-Za-km-z]*$/;
        my $decoded_array_size = length($input);
        my @byte;
        #Counts number of leading 1's in bitcoin address.
        my $leading_ones = length($1) if $input =~ /^(1*)/;

        # Cycle through each character of address, decoding from Base58.
        foreach my $b58_char ( map { $b58{$_} } $input =~ /./g )
	{
                # Cycle through each byte
                for (my $dbi = $decoded_array_size; $dbi--; )
		{
                        $b58_char += 58 * ($byte[$dbi] // 0);
                        $byte[$dbi] = $b58_char % 256;
                        $b58_char /= 256;
                }
        }
        # Counts number of leading zeroes in @byte
        my $leading_zeroes = length($1) if join('', @byte) =~ /^(0*)/;

        # if leading zeroes of decoded address don't equal leading ones
	# of encoded address, trim them off.
        for (1 .. $leading_zeroes - $leading_ones)
	{
                shift @byte;
        }
        return ( 1, @byte );
}


#
# my $isvalid = valid_bitcoin_type1_or_3( $address );
#	Given a type 1 or type 3 Bitcoin address $address,
#	return true iff it's valid.
#       Code adapted from http://lenschulwitz.com/b58/base58perl.txt
#
fun valid_bitcoin_type1_or_3( $address )
{
	return 0 unless $address =~ /^[13]/;

        my( $validbase58, @byte ) = unbase58( $address );
        return 0 unless $validbase58 && @byte == 25;

        # See if last 4 bytes of the 25-byte base58 decoded bitcoin address
	# match the double sha256 hash of the first 21 bytes.
        my $checksum = pack 'C*', @byte[21..24];
        my $payload = pack 'C*', @byte[0..20];
	my $newchecksum = substr( sha256(sha256($payload)), 0, 4 );
        return 0 unless $checksum eq $newchecksum;

        return 1;
}



die "Usage: ch-2.pl BITCOIN_ADDRESS+\n" if @ARGV == 0;

foreach my $address (@ARGV)
{
	my $isvalid = valid_bitcoin_type1_or_3( $address );
	print "$address: ", $isvalid?"yes":"no", "\n";
}
