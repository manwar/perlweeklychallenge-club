#!/usr/bin/raku

sub makeover($str) {
    my $result = 
        $str.NFD
        .list.map({ chr($_); })
        .Str;

    state %special = (
        "\c[LATIN CAPITAL LETTER AE]"            => 'AE',
        "\c[LATIN CAPITAL LETTER ETH]"           => 'D',
        "\c[LATIN CAPITAL LETTER F WITH HOOK]"   => 'F',
        "\c[LATIN CAPITAL LETTER O WITH STROKE]" => 'O',
        "\c[LATIN CAPITAL LETTER SHARP S]"       => 'SS',
        "\c[LATIN CAPITAL LETTER THORN]"         => 'TH',
        "\c[LATIN SMALL LETTER AE]"              => 'ae',
        "\c[LATIN SMALL LETTER ETH]"             => 'd',
        "\c[LATIN SMALL LETTER F WITH HOOK]"     => 'f',
        "\c[LATIN SMALL LETTER O WITH STROKE]"   => 'o',
        "\c[LATIN SMALL LETTER SHARP S]"         => 'ss',
        "\c[LATIN SMALL LETTER THORN]"           => 'th',
        "\c[LATIN CAPITAL LIGATURE OE]"          => 'OE',
        "\c[LATIN SMALL LIGATURE OE]"            => 'oe',
    );
    for %special.keys -> $k {
        $result = $result.subst(/$k/, %special{$k}, :g);
    }

    $result = $result.subst(/<-[a..zA..Z]>*/, q{}, :g);

    return $result;
}

sub MAIN() {
    say makeover('ÃÊÍÒÙ');
    say makeover('âÊíÒÙ');
    say makeover('ÆÐØẞÞæðøßþŒœƑƒ');
}