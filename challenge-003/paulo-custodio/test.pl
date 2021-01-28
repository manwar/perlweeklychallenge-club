#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

my $LUA = ($^O eq 'msys') ? "lua.exe" : "lua";

run("gcc     c/ch-1.c   -o     c/ch-1");
run("g++   cpp/ch-1.cpp -o   cpp/ch-1");
run("fbc basic/ch-1.bas -o basic/ch-1");

for ([20 => <<END]) {
1
2
3
4
5
6
8
9
10
12
15
16
18
20
24
25
27
30
32
36
END
    my($in, $out) = @$_;

    is capture(     "$LUA lua/ch-1.lua $in"), $out;
    is capture(    "perl perl/ch-1.pl  $in"), $out;
    is capture( "gforth forth/ch-1.fs  $in"), $out;
    is capture("python python/ch-1.py  $in"), $out;
    is capture(            "c/ch-1     $in"), $out;
    is capture(          "cpp/ch-1     $in"), $out;
    is capture(        "basic/ch-1     $in"), $out;
}

run("gcc     c/ch-2.c   -o     c/ch-2");
run("g++   cpp/ch-2.cpp -o   cpp/ch-2");
run("fbc basic/ch-2.bas -o basic/ch-2");

for ([10 => <<END]) {
         1
        1 1
       1 2 1
      1 3 3 1
     1 4 6 4 1
    1 5 10 10 5 1
   1 6 15 20 15 6 1
  1 7 21 35 35 21 7 1
 1 8 28 56 70 56 28 8 1
1 9 36 84 126 126 84 36 9 1
END
    my($in, $out) = @$_;

    is capture(      "$LUA lua/ch-2.lua    $in "), $out;
    is capture(     "perl perl/ch-2.pl     $in "), $out;
    is capture(  "gforth forth/ch-2.fs     $in "), $out;
    is capture( "python python/ch-2.py     $in "), $out;
    is capture(             "c/ch-2        $in "), $out;
    is capture(           "cpp/ch-2        $in "), $out;
    is capture(         "basic/ch-2        $in "), $out;
}

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}

sub run {
    my($cmd) = @_;
    ok 0==system($cmd), $cmd;
}
