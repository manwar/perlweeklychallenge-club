#!/usr/bin/env perl6
use v6;

# wrapper around
#https://gitlab.com/pheix/lzw-revolunet-perl6
# mimics the functionality of the python script at
# https://rosettacode.org/wiki/LZW_compression#Python

use LZW::Revolunet;

my Int $r;
my $lzw = LZW::Revolunet.new( dictsize => 256 );

my %*SUB-MAIN-OPTS=:named-anywhere,;
multi sub MAIN(
    Str $text,
    Bool :e(:$encode),    
) {    
    my $cmp = $lzw.compress( $lzw.encode_utf8($text), :ratio($r) );
    say $cmp.comb.map(*.ord);    
}

multi sub MAIN(
    Bool :d(:$decode),
    *@ARGS,
) {
    say $lzw.decode_utf8( $lzw.decompress(@ARGS.map({ $_.chr }).join) );    
}
