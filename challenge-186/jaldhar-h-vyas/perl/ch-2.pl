#!/usr/bin/perl
use 5.030;
use warnings;
use utf8;
use Unicode::Normalize qw/ normalize /;

sub makeover {
    my ($str) = @_;

    my $result = normalize('D', $str);

    state %special = (
        "\N{LATIN CAPITAL LETTER AE}"            => 'AE',
        "\N{LATIN CAPITAL LETTER ETH}"           => 'D',
        "\N{LATIN CAPITAL LETTER F WITH HOOK}"   => 'F',
        "\N{LATIN CAPITAL LETTER O WITH STROKE}" => 'O',
        "\N{LATIN CAPITAL LETTER SHARP S}"       => 'SS',
        "\N{LATIN CAPITAL LETTER THORN}"         => 'TH',
        "\N{LATIN SMALL LETTER AE}"              => 'ae',
        "\N{LATIN SMALL LETTER ETH}"             => 'd',
        "\N{LATIN SMALL LETTER F WITH HOOK}"     => 'f',
        "\N{LATIN SMALL LETTER O WITH STROKE}"   => 'o',
        "\N{LATIN SMALL LETTER SHARP S}"         => 'ss',
        "\N{LATIN SMALL LETTER THORN}"           => 'th',
        "\N{LATIN CAPITAL LIGATURE OE}"          => 'OE',
        "\N{LATIN SMALL LIGATURE OE}"            => 'oe',
    );
    for my $k (keys %special) {
        $result =~ s/$k/$special{$k}/g;
    }

    $result =~ s/[^a-zA-Z]+//g;

    return $result;
}

say makeover('ÃÊÍÒÙ');
say makeover('âÊíÒÙ');
say makeover('ÆÐØẞÞæðøßþŒœƑƒ');
