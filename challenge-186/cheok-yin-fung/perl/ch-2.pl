use v5.30.0;
use charnames ();
use utf8;

sub ch_latin {
    my $name = charnames::viacode(ord($_[0]));
    return $1 if $name =~ /^LATIN CAPITAL LETTER (\w)/;
    return lc($1) if $name =~ /^LATIN SMALL LETTER (\w)/;
    return $_[0];
}

sub makeover {
    return join "", map {ch_latin $_} split "", $_[0]
}

use Test::More tests=>4;
ok makeover("ÃÊÍÒÙ") eq "AEIOU";
ok makeover("âÊíÒÙ") eq "aEiOU";
ok makeover("chữ Quốc ngữ") eq "chu Quoc ngu";
ok makeover("Paul Erdős") eq "Paul Erdos";
