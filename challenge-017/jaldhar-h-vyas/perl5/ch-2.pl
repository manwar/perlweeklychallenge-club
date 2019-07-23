#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my $dec_octet = qr / \d | [1-9]\d | 1\d\d | 2[0-4]\d | 25[0-5] /x;
my $hex_octet = qr /  [ 0-9 A-F a-f ]{2} /x;
my $pct_encoded = qr/ % $hex_octet /x;
my $sub_delim  = qr/ [ ! $ & ' ( ) * + , ; = ] /x;
my $scheme = qr/ [ A-Z a-z 0-9 + - . ] /x;
my $unreserved = qr/ [ A-Z a-z 0-9 - . _ ~ ] /x;

my $ipv4 = qr/$dec_octet \. $dec_octet \. $dec_octet \. $dec_octet /x;
my $userinfo = qr/ $unreserved | $pct_encoded | $sub_delim | : /x;
my $pchar = qr/ $userinfo | @ /x;
my $path = qr / $pchar | \/ /x;
my $query_or_fragment = qr/ $pchar | \/ | \? /x;

my $url = shift;

$url =~ /
    \A
    (?<scheme>$scheme+)
    :
    (?:
        \/\/?
        (?: (?<userinfo> $userinfo+? ) @ )?
        (?<host> $ipv4 | $unreserved+ )
        (?: : (?<port> \d+ ) )?
    )?
    (?<path> $path+ )?
    (?: \? (?<query> $query_or_fragment+ ) )?
    (?: \# (?<fragment> $query_or_fragment+ ) )?
    # \z
/msx;

for my $part (qw/ scheme userinfo host port path query fragment /) {
    say "$part: ", $+{$part} // q{};
}
