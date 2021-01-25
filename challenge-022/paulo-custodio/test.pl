#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

is capture("perl perl/ch-1.pl"), <<END;
(5, 11)
(7, 13)
(11, 17)
(13, 19)
(17, 23)
(23, 29)
(31, 37)
(37, 43)
(41, 47)
(47, 53)
END

my($text, $encoded) = ("TOBEORNOTTOBEORTOBEORNOT", join("", qw(
                      10100
                      01111
                      00010
                      00101
                      01111
                      10010
                      001110
                      001111
                      010100
                      011011
                      011101
                      011111
                      100100
                      011110
                      100000
                      100010
                      000000
                      )));

is capture("perl perl/ch-2.pl encode $text"), "$encoded\n", "$text -> $encoded";
is capture("perl perl/ch-2.pl decode $encoded"), "$text\n", "$encoded -> $text";

done_testing;


sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
