#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

# build list of words for testing
ok 0==system("aspell -d en dump master | aspell -l en expand > words.txt");


for ([50, <<END]) {
1
2
3
4
5
6
7
8
9
10
12
18
20
21
24
27
30
36
40
42
45
48
50
END
    my($in, $out) = @$_;

    is capture(    "perl perl/ch-1.pl $in"), $out;
    is capture("python python/ch-1.py $in"), $out;
}


for (["cold warm", <<END]) {
("cold", "cord", "card", "ward", "warm")
END
    my($in, $out) = @$_;

    is capture(    "perl perl/ch-2.pl $in"), $out;
    is capture("python python/ch-2.py $in"), $out;
}

unlink "words.txt";
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}
