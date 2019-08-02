use strict;
use warnings;
use Const::Fast;
use Crypt::Misc qw( decode_b58b );
use Digest::SHA;

const my $DEFAULT_ADDR  => '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2';
const my %ADDR_FORMATS  => (1   => 'P2PKH', 3 => 'P2SH',
                            bc1 => 'Bech32');
const my $INVALID_CHARS =>  qr{([^1-9A-HJ-NP-Za-km-z])};
const my $MAX_CHARS     =>  35;
const my $MIN_CHARS     =>  26;
const my $SHA_ALGORITHM => 256;
const my $TAB           => '  ';

MAIN:
{
    my $address = $ARGV[0] // $DEFAULT_ADDR;

    print "\nBitcoin address: \"$address\"\n";

    if (my $error = validate_format($address, \my $format))
    {
        print "${TAB}Format validation FAILED: $error\n";
    }
    elsif ($format eq 'Bech32')
    {
        print "${TAB}Bech32 format not currently supported\n";
    }
    else
    {
        print "${TAB}Format is \"$format\"\n";

        if ($error = validate_chars($address))
        {
            print "${TAB}Character validation FAILED: $error\n";
        }
        elsif (validate_checksum($address))
        {
            print "${TAB}Checksum validation PASSED\n";
        }
        else
        {
            print "${TAB}Checksum validation FAILED\n";
        }
    }
}

sub validate_format
{
    my ($address, $format) = @_;
    my  $error;

    for my $prefix (keys %ADDR_FORMATS)
    {
        if ($address =~ qr/^$prefix/)
        {
            $$format = $ADDR_FORMATS{$prefix};
            last;
        }
    }

    unless (defined $$format)
    {
        my $len = substr($address, 0, 1) eq 'b' ?
                  substr($address, 1, 1) eq 'c' ? 3 : 2 : 1;
        $error  = 'invalid prefix "' . substr($address, 0, $len) .
                  '", unknown format';
    }

    return $error;
}

sub validate_chars
{
    my ($address) = @_;
    my  $chars    = length $address;
    my  $error;

    if    ($chars < $MIN_CHARS)
    {
        $error = "invalid length $chars (minimum is $MIN_CHARS)";
    }
    elsif ($chars > $MAX_CHARS)
    {
        $error = "invalid length $chars (maximum is $MAX_CHARS)";
    }
    elsif ($address =~ $INVALID_CHARS)
    {
        $error = "invalid character \"$1\"";
    }

    return $error;
}

sub validate_checksum
{
    my ($address)  = @_;
    my  $rawdata   = decode_b58b($address);      # Base58 to bytes
    my  $hexdata   = unpack 'H*', $rawdata;      # Bytes  to hex
    my  $checksum1 = substr  $hexdata, -8;       # Checksum 1 in hex
    my  $payload   = substr  $hexdata,  0, -8;   # Payload in hex
    my  $sha_obj   = Digest::SHA->new($SHA_ALGORITHM);
        $sha_obj->add(pack 'H*', $payload);      # Hex to bytes
    my  $digest1   = $sha_obj->hexdigest;        # 1st digest in hex
        $sha_obj->add(pack 'H*', $digest1);      # hex to bytes
    my  $digest2   = $sha_obj->hexdigest;        # 2nd digest in hex
    my  $checksum2 = substr  $digest2,  0,  8;   # Checksum 2 in hex

    return $checksum1 eq $checksum2;             # Compare checksums
}
