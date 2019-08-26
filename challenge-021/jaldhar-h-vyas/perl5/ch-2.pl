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

sub parse {
    my ($url) = @_;

    $url =~ /
        \A
        (?<scheme>$scheme+)
        :
        (?:
            (?<slashes>\/\/)?
            (?: (?<userinfo> $userinfo+? ) @ )?
            (?<host> $ipv4 | $unreserved+ )
            (?: : (?<port> \d+ ) )?
        )?
        (?<path> $path+ )?
        (?: \? (?<query> $query_or_fragment+ ) )?
        (?: \# (?<fragment> $query_or_fragment+ ) )?
        # \z
    /msx;

    my $parsed = {};
    for my $part (qw/ scheme slashes userinfo host port path query fragment /) {
        $parsed->{$part} = $+{$part} // undef;
    }
    return $parsed;
}

sub lowerCase {
    my ($url) = @_;
    my $result = $url;

    $result->{scheme} =~ tr/A-Z/a-z/;
    $result->{host} =~ tr/A-Z/a-z/;

    return $result;
}

sub capitalizeEscape {
    my ($url) = @_;
    my $result = $url;

    for my $part (qw/ userinfo path query fragment /) {
        $result->{$part} =~ s/($pct_encoded)/\U$1/g;
    }

    return $result;
}

sub decodeUnreserved {
    my ($url) = @_;
    my $result = $url;

    for my $part (qw/ userinfo path query fragment /) {
        while ($result->{$part} =~ /($pct_encoded)/g) {
            my $pct = $1;
            my $hex = $pct;
            $hex =~ s/%//;
            if (hex($hex) =~ /$unreserved/) {
                my $decoded = chr(hex($hex));
                $result->{$part} =~ s/$pct/$decoded/;
            }
        }
    }

    return $result;
}

sub removeDefaultPort {
    my ($url) = @_;
    my $result = $url;

    if ($result->{port} eq '80') {
        $result->{port} = undef;
    }

    return $result;
}
sub reassemble {
    my ($url) = @_;

    my $result = "$url->{scheme}:";
    $result .= $url->{slashes} // q{};
    $result .= $url->{userinfo} // q{};
    if (defined $url->{userinfo}) {
        $result .= '@';
    }
    $result .= $url->{host} // q{};
    if (defined $url->{port}) {
        $result .= ":$url->{port}";
    }
    $result .= $url->{path} // q{};
    $result .= "?$url->{query}" // q{};
    $result .= "#$url->{fragment}" // q{};

    return $result;
}

say reassemble(
    decodeUnreserved(
        capitalizeEscape(
            removeDefaultPort(
                lowerCase(
                    parse(
                        shift
                    )
                )
            )
        )
    )
);
