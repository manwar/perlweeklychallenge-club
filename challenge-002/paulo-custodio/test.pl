#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

my $LUA = ($^O eq 'msys') ? "lua.exe" : "lua";

run("gcc     c/ch-1.c   -o     c/ch-1");
run("g++   cpp/ch-1.cpp -o   cpp/ch-1");
run("fbc basic/ch-1.bas -o basic/ch-1");

for ([     "0" => "0"],
     ["000123" => "123"],
     ["123"	   => "123"],
     ["-00123" => "-00123"],
     ["-123"   => "-123"]) {
	my($in, $out) = @$_;
	
	is capture(     "$LUA lua/ch-1.lua $in"), "$out\n";
	is capture(    "perl perl/ch-1.pl  $in"), "$out\n";
	is capture( "gforth forth/ch-1.fs  $in"), "$out\n";
	is capture("python python/ch-1.py  $in"), "$out\n";
	is capture(            "c/ch-1     $in"), "$out\n";
	is capture(          "cpp/ch-1     $in"), "$out\n";
	is capture(        "basic/ch-1     $in"), "$out\n";
}

run("gcc     c/ch-2.c   -o     c/ch-2");
run("g++   cpp/ch-2.cpp -o   cpp/ch-2");
run("fbc basic/ch-2.bas -o basic/ch-2");

for ([  "0" =>   "0"],
     [  "1" =>   "1"],
     [ "34" =>   "Y"],
     ["-35" => "-10"]) {
	my($in, $out) = @$_;

	is capture(      "$LUA lua/ch-2.lua    $in "), "$out\n";
	is capture(      "$LUA lua/ch-2.lua -r $out"), "$in\n";
	is capture(     "perl perl/ch-2.pl     $in "), "$out\n";
	is capture(     "perl perl/ch-2.pl  -r $out"), "$in\n";
	is capture(  "gforth forth/ch-2.fs     $in "), "$out\n";
	is capture(  "gforth forth/ch-2.fs  -r $out"), "$in\n";
	is capture( "python python/ch-2.py     $in "), "$out\n";
	is capture( "python python/ch-2.py  -r $out"), "$in\n";
	is capture(            "c/ch-2         $in "), "$out\n";
	is capture(            "c/ch-2      -r $out"), "$in\n";
	is capture(          "cpp/ch-2         $in "), "$out\n";
	is capture(          "cpp/ch-2      -r $out"), "$in\n";
#	is capture(        "basic/ch-2         $in "), "$out\n";
#	is capture(        "basic/ch-2      -r $out"), "$in\n";
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
