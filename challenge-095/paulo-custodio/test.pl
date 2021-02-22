#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

compile("gcc     c/ch-1.c   -o   c/ch-1");
compile("g++   cpp/ch-1.cpp -o cpp/ch-1");
compile("fbc basic/ch-1.bas");

for ([1221 => 1], [101 => 1], [-101 => 0], [90 => 0]) {
    my($in, $out) = @$_;
    is capture(    "perl perl/ch-1.pl $in"), "$out\n";
    is capture("python python/ch-1.py $in"), "$out\n";
    is capture("gforth  forth/ch-1.fs $in"), "$out\n";
    is capture(               "c/ch-1 $in"), "$out\n";
    is capture(             "cpp/ch-1 $in"), "$out\n";
    is capture(           "basic/ch-1 $in"), "$out\n";
}

compile("gcc     c/ch-2.c   -o   c/ch-2");
compile("g++   cpp/ch-2.cpp -o cpp/ch-2");
compile("fbc basic/ch-2.bas");

my $out = <<END;
-1
-1
END
is capture(    "perl perl/ch-2.pl"), $out;
is capture("python python/ch-2.py"), $out;
is capture("gforth  forth/ch-2.fs"), $out;
is capture(            "c/ch-2"   ), $out;
is capture(          "cpp/ch-2"   ), $out;
is capture(        "basic/ch-2"   ), $out;

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}

sub compile {
    my($cmd) = @_;
    ok 0==system($cmd), $cmd;
}
