# Write a script to validate a given bitcoin address.
# Most Bitcoin addresses are 34 characters.
# They consist of random digits and uppercase and lowercase letters,
# with the exception that the uppercase letter “O”, uppercase letter “I”,
# lowercase letter “l”, and the number “0” are never used to prevent
# visual ambiguity. A bitcoin address encodes 25 bytes. The last four
# bytes are a checksum check. They are the first four bytes of a
# double SHA-256 digest of the previous 21 bytes. For more information,
# please refer wiki page.
# Here are some valid bitcoin addresses:
#
# 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
# 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

use strict;
use warnings;
use Digest::SHA qw/sha256 sha256_hex/;

# we start by defining an array with the ordered symbols of the
# base 58 representation
# note the "holes" left to highlight the non existing characters
# (number "0", upper case letter "I", upper case letter "O", and
# lower case letter "l"

my @base58 = qw {
  1 2 3 4 5 6 7 8 9
  A B C D E F G H   J K L M N   P Q R S T U V W X Y Z
  a b c d e f g h i j k   m n o p q r s t u v w x y z
};

# whith this list we can build part of a regexp to
# check matchings for these chars only
# like 1|2|3..y|z

my $ored_chars = join( '|', @base58 );

# we can also build a hash to convert each symbol
# to its code value, like

my %base58_codes = map { $base58[$_] => $_ } 0 .. 57;

# now we can define the decode58 function. That is,
# given a string encoded with our base58 representation,
# we return an array of 25 decoded integers (bytes)

# as we don't want to use a BigInt module and the binary
# result will indeed represent a big integer, we are going to take
# care of the internal math manually, just adding byte by
# byte and taking care of carrying values

sub decode58 {

    # we assume that the input is a valid base58 encoded string
    my $in = shift;
    my @out;    # here is where the end result is calculated
    for my $c ( split '', $in ) {

        # first we multiply all @out values by 58
        # (this will be no operation on first pass).
        # Note also that by doing this, we will end with a non
        # very well formated integer represented array, in the
        # sense that we will probably have values > 255
        # in several of its elements.
        # But this is not going to be a problem because we will
        # normalyse the array after adding the new char code
        # below, taking care of elements greater than 255
        $_ *= 58 for @out;

        # and now we add code value char by char.
        # Note that $out[0] will be the least significant
        # byte of the result
        $out[0] += $base58_codes{$c};

        # now we do the carry on every value of @out, starting
        # with $out[0], when it exceeds byte max value (255)
        # this is the "normalization" process we refered above
        for my $i ( 0 .. $#out ) {
            my $v = $out[$i];
            next unless $v > 255;

            # here we need to carry excess of 256 to $out[$i+1]
            $out[ $i + 1 ] += int( $v / 256 );

            # and adjust $out[$i] accordingly
            $out[$i] = $v % 256;
        }
    }

    # we now left-pad calculated @out, to always return a 25 bytes
    # array
    $out[$_] //= 0 for 0 .. 24;

    # now we return calculated @out, just taking care of
    # the right order, wich is most significant byte first
    return reverse @out;
}

# with that decode58 function, we just write the script according
# to valid bitcoin address definitions

my $address_to_check = shift;

die "Invalid format address"
  unless $address_to_check =~ /^($ored_chars){26,35}$/;

my @decoded = decode58($address_to_check);
my $double256 = sha256( sha256( pack 'C*', @decoded[ 0 .. 20 ] ) );

# note that pack 'C*', @decoded[0..20] will be the first 21 bytes
# of the decoded result properly concatenated to be hashed by sha256

my $check256 = pack 'C*', @decoded[ 21 .. 24 ];

die "Checksum verification error on address"
  unless $check256 eq substr( $double256, 0, 4 );

printf "%s is a valid bitcoin address\n", $address_to_check;
