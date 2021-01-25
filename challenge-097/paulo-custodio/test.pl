#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;

# hack so that output redirection works in msys
my $LUA = $^O eq "msys" ? "lua.exe" : "lua";

run("gcc     c/ch-1.c   -o     c/ch-1");
run("g++   cpp/ch-1.cpp -o   cpp/ch-1");
run("fbc basic/ch-1.bas -o basic/ch-1");

for (["THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"
   => "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"]) {
    my($in, $out) = @$_;

    is capture(     "perl perl/ch-1.pl  3 $in "), "$out\n";
    is capture(     "perl perl/ch-1.pl -3 $out"), "$in\n";
    is capture(     "$LUA lua/ch-1.lua  3 $in "), "$out\n";
    is capture(     "$LUA lua/ch-1.lua -3 $out"), "$in\n";
    is capture(  "gforth forth/ch-1.fs  3 $in "), "$out\n";
    is capture(  "gforth forth/ch-1.fs -3 $out"), "$in\n";
    is capture( "python python/ch-1.py  3 $in "), "$out\n";
    is capture( "python python/ch-1.py -3 $out"), "$in\n";
    is capture(             "c/ch-1     3 $in "), "$out\n";
    is capture(             "c/ch-1    -3 $out"), "$in\n";
    is capture(           "cpp/ch-1     3 $in "), "$out\n";
    is capture(           "cpp/ch-1    -3 $out"), "$in\n";
    is capture(         "basic/ch-1     3 $in "), "$out\n";
    is capture(         "basic/ch-1    -3 $out"), "$in\n";
}

run("gcc     c/ch-2.c   -o     c/ch-2");
run("g++   cpp/ch-2.cpp -o   cpp/ch-2");
run("fbc basic/ch-2.bas -o basic/ch-2");

for (["101100101 3" => "1"],
     ["10110111  4" => "2"]) {
    my($in, $out) = @$_;

    is capture(    "perl perl/ch-2.pl  $in"), "$out\n";
    is capture(     "$LUA lua/ch-2.lua $in"), "$out\n";
    is capture( "gforth forth/ch-2.fs  $in"), "$out\n";
    is capture("python python/ch-2.py  $in"), "$out\n";
    is capture(            "c/ch-2     $in"), "$out\n";
    is capture(          "cpp/ch-2     $in"), "$out\n";
    is capture(        "basic/ch-2     $in"), "$out\n";
}

done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \r\t]*\n/\n/g;
    return $out;
}

sub run {
    my($cmd) = @_;
    ok 0==system($cmd), $cmd;
}
