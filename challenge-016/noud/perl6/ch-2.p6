# Write a script to validate a given bitcoin address. Most Bitcoin addresses
# are 34 characters. They consist of random digits and uppercase and lowercase
# letters, with the exception that the uppercase letter “O”, uppercase letter
# “I”, lowercase letter “l”, and the number “0” are never used to prevent
# visual ambiguity. A bitcoin address encodes 25 bytes. The last four bytes are
# a checksum check. They are the first four bytes of a double SHA-256 digest of
# the previous 21 bytes. For more information, please refer wiki page. Here are
# some valid bitcoin addresses:
#
#    1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
#    3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy
#

use Digest::SHA;

sub valid_bitcoin(Str $bc) {
    # Check that the bitcoin hash is of the correct size.
    if ($bc.chars > 34 || $bc.chars < 24) {
        return False;
    }

    # The bitcoinhash should start with 1 or 3 and should not contain an
    # O, I, l, or 0.
    if (! $bc ~~ / ^(1|3)(<[1..9A..HJ..NP..Za..km..z]>+)$ / ) {
        return False;
    }

    # Convert Bitcoin hash base 58 to base 10.
    # Example: [1, 2, 3].reduce(* * 58 + *) = (1 * 58 + 2) * 58 + 3
    #                                       = 1 * 58^2 + 2 * 58 + 3
    my %base58 = (1..9, 'A'..'H', 'J'..'N', 'P'..'Z', 'a'..'k', 'm'..'z')
        .flat.pairs.invert.hash;
    my $dec = %base58{$bc.comb}.reduce(* * 58 + *);

    # Compute the double sha-256 hash of the first 21 bytes.
    my $bin_blob = Blob.new($dec.polymod(2 ** 8 xx 24).reverse);
    my $bc_hash = sha256(sha256($bin_blob.subbuf(0, 21)));

    # The last 4 bytes of the hash should be equal to the first 4 bytes of the
    # double sha-256 hash.
    return $bin_blob.subbuf(21, 4) eqv $bc_hash.subbuf(0, 4);
}


# Two valid bitcoin hashes.
my $bc1 = '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2';
my $bc2 = '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy';

# Two invalid bitcoin hashes.
my $bc3 = '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN3';
my $bc4 = '3J99t1WpEZ73CNmQviecrnyiWrnqRhWNLy';

valid_bitcoin($bc1).say;  # Returns: True
valid_bitcoin($bc2).say;  # Returns: True
valid_bitcoin($bc3).say;  # Returns: False
valid_bitcoin($bc4).say;  # Returns: False
