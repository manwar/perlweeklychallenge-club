#!/usr/bin/perl

use strict;
use warnings;
use 5.030;
use Test::More;
use Path::Tiny;

my $input = "input.txt";

compile("gcc -o   c/ch-1     c/ch-1.c");
compile("g++ -o cpp/ch-1   cpp/ch-1.cpp");
compile("fbc             basic/ch-1.bas");

for (["1 1  2 2  3 4"           => 2],
     ["1 1  2 2  3 1  1 3  5 3" => 3]) {
    my($in, $out) = @$_;

    is capture(    "perl perl/ch-1.pl $in"),  "$out\n";
    is capture("python python/ch-1.py $in"),  "$out\n";
    is capture( "gforth forth/ch-1.fs $in"),  "$out\n";
    is capture(            "c/ch-1    $in"),  "$out\n";
    is capture(          "cpp/ch-1    $in"),  "$out\n";
    is capture(        "basic/ch-1    $in"), " $out\n";
}


compile("gcc -o c/ch-2       c/ch-2.c");
compile("g++ -o cpp/ch-2   cpp/ch-2.cpp");
compile("fbc             basic/ch-2.bas");

for ([<<'END' => 13],
      1
     /
    2
   / \
  3   4
END
    [<<'END' => 26]) {
      1
     / \
    2   3
   /   / \
  4   5   6
END
    my($in, $out) = @$_;
    path($input)->spew($in);

    is capture(    "perl perl/ch-2.pl < $input"),  "$out\n";
    is capture("python python/ch-2.py < $input"),  "$out\n";
    is capture( "gforth forth/ch-2.fs < $input"),  "$out\n";
    is capture(            "c/ch-2    < $input"),  "$out\n";
    is capture(          "cpp/ch-2    < $input"),  "$out\n";
    is capture(        "basic/ch-2    < $input"), " $out\n";
}


unlink $input;
done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/[ \t\v\f\r]*\n/\n/g;
    return $out;
}

sub compile {
    my($cmd) = @_;
    0==system($cmd) or die "Compile failed: $cmd\n";
}
