#!/usr/bin/perl
use warnings;
use strict;

sub wrap_paragraph {
    my ($paragraph, $width) = @_;
    $paragraph =~ s/ *\n */ /g;
    my $out = "";
    while (length $paragraph) {
        my $pos;
        if (length $paragraph <= $width) {
            $pos = length $paragraph;
        } else {
            $pos = $width;
            --$pos until ' ' eq substr $paragraph, $pos, 1
                   or $pos < 0;
            $pos = $width if $pos < 0;
        }
        $out .= substr $paragraph, 0, $pos, "";
        $paragraph =~ s/^ +//;
        $out .= "\n" if length $paragraph;
    }
    return $out
}

use Test::More;

my %expected = (
    'a'                 => "a",
    'bcdef'             => "bcdef",
    'ghijkl'            => "ghijk\nl",
    'm no pq'           => "m no\npq",
    'rs tu vw'          => "rs tu\nvw",
    'xyz ab cd'         => "xyz\nab cd",
    'efgh ij kl'        => "efgh\nij kl",
    'mnopq rs tu'       => "mnopq\nrs tu",
    'vwxyza bc de'      => "vwxyz\na bc\nde",
    'fghijkl mn op'     => "fghij\nkl mn\nop",
    'qrstuvwx yz ab'    => "qrstu\nvwx\nyz ab",
    'cdefghijk lm no'   => "cdefg\nhijk\nlm no",
    'pqrstuvwxy za bc'  => "pqrst\nuvwxy\nza bc",
    'defghijklmn op qr' => "defgh\nijklm\nn op\nqr",
    "s\nt"              => "s t",
    "u\nv\n w"          => "u v w",
    << '__PAR__', << '__EXPECTED__' =~ s/\n$//r);
ABCDE
AABBCC
A BB CC
AA BB CC
AAA BB CC
AAAA BB CC
AAAAA BB CC
__PAR__
ABCDE
AABBC
C A
BB CC
AA BB
CC
AAA
BB CC
AAAA
BB CC
AAAAA
BB CC
__EXPECTED__

for my $in (keys %expected) {
    is wrap_paragraph($in, 5), $expected{$in}, $in;
    is wrap_paragraph($expected{$in}, 5), $expected{$in},
        "idempotent $expected{$in}";
}

done_testing();
