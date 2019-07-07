#!/usr/bin/env perl6
#
# Vigenère-cipher encoder/decoder
# Operates on capitalized input- and kextexts only
#

sub encode (Str $key   where { 'A' le $key   le 'Z' },
            Str $plain where { 'A' le $plain le 'Z' })
{
    my $base            = 'A'.ord;                                                      # unicode base point of alphabet
    my $column_index    = $plain.ord - $base;                                           # calculate col.index of plaintext char on encoding row
    my $alphab_index    = (( $key.ord - $base ) + $column_index) % ('A'..'Z').elems;    # calculate alphabet index of cipher character
    my $cipher          = ($base + $alphab_index).chr;                                  # convert back to unicode code point
    return $cipher;
}



sub decode (Str $key    where { 'A' le $key    le 'Z' },
            Str $cipher where { 'A' le $cipher le 'Z' })
{
    my $base            = $key.ord;                         # base/first letter of decoding row in Vignére table
    my $column_index    = $cipher.ord - $base;              # column index of $cipher in Vignère table on decoding row
    my $alphab_index    = $column_index % ('A'..'Z').elems; # zero-based index of column index into alphabet
    my $plain           = ('A'.ord + $alphab_index).chr;    # convert back to unicode code point
    return $plain;
}



sub MAIN (Str $cmd, Str $inputtext, Str $keytext )
{
    my %commands   = 'encode' => &encode,
                     'decode' => &decode;

    my &func       = %commands{$cmd};
    my @inputtext  = $inputtext.uc.comb;
    my @keytext    = $keytext.uc.comb;
    my $outputtext;

    for 0..(@inputtext.elems - 1) -> $i {
        my $keytext_index = $i % @keytext.elems;
        $outputtext ~= &func(@keytext[$keytext_index], @inputtext[$i]);
    }
    say $outputtext;
}
