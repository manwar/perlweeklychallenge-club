use v6;
use experimental :pack;
use Crypt::Misc:from<Perl5> <decode_b58b>;
use Digest::SHA256::Native;

my Sub $decode_b58b := &Crypt::Misc::decode_b58b;

my       constant %ADDR-FORMATS  =
                  (1 => 'P2PKH', 3 => 'P2SH', bc1 => 'Bech32');
my Str   constant $DEFAULT-ADDR  =
                  '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2';
my Regex constant $INVALID-CHARS =
                  rx{ ( <-[1..9A..HJ..NP..Za..km..z]> ) };
my UInt  constant $MAX-CHARS     =  35;
my UInt  constant $MIN-CHARS     =  26;
my Str   constant $TAB           = '  ';

sub MAIN(Str:D $address = $DEFAULT-ADDR)
{
    print "\nBitcoin address: \"$address\"\n";
    my Str:D $format = '';

    if my $error = validate-format($address, $format)
    {
        print "{$TAB}Format validation FAILED: $error\n";
    }
    elsif $format eq 'Bech32'
    {
        print "{$TAB}Bech32 format not currently supported\n";
    }
    else
    {
        print "{$TAB}Format is \"$format\"\n";

        if $error = validate-chars($address)
        {
            print "{$TAB}Character validation FAILED: $error\n";
        }
        elsif validate-checksum($address)
        {
            print "{$TAB}Checksum validation PASSED\n";
        }
        else
        {
            print "{$TAB}Checksum validation FAILED\n";
        }
    }
}

sub validate-format(Str:D $address, Str:D $format is rw)
{
    my Str $error;

    for keys %ADDR-FORMATS -> Str $prefix
    {
        if $address ~~ /^$prefix/
        {
            $format = %ADDR-FORMATS{$prefix};
            last;
        }
    }

    unless $format
    {
        my UInt $len = $address.substr(0, 1) eq 'b' ??
                       $address.substr(1, 1) eq 'c' ?? 3 !! 2 !! 1;

        $error = 'invalid prefix "' ~ $address.substr(0, $len) ~
                 '", unknown format';
    }

    return $error;
}

sub validate-chars(Str:D $address)
{
    my $chars = $address.chars;
    my Str $error;

    if $chars < $MIN-CHARS
    {
        $error = "invalid length $chars (minimum is $MIN-CHARS)";
    }
    elsif $chars > $MAX-CHARS
    {
        $error = "invalid length $chars (maximum is $MAX-CHARS)";
    }
    elsif $address ~~ $INVALID-CHARS
    {
        $error = "invalid character \"$0\"";
    }

    return $error;
}

sub validate-checksum(Str:D $address)
{
    my Blob[uint8] $raw-data      = $decode_b58b($address);
    my Str         $hex-data      = $raw-data.unpack('H*');
    my Str         $hex-checksum1 = $hex-data.substr(*-8);
    my Str         $hex-payload   = $hex-data.substr(0, *-8);
    my Blob[uint8] $raw-payload   = pack('H*', $hex-payload);
    my Str         $hex-digest1   = sha256-hex($raw-payload);
    my Blob[uint8] $raw_digest1   = pack('H*', $hex-digest1);
    my Str         $hex-digest2   = sha256-hex($raw_digest1);
    my Str         $hex-checksum2 = $hex-digest2.substr(0, 8);

    return $hex-checksum1 eq $hex-checksum2;
}
