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


for (["opt bat saw tab pot top was" => <<END],
[ ("bat", "tab"),
  ("saw", "was"),
  ("opt", "pot", "top") ]
END
     ["x" => <<END]) {
[ ("x") ]
END
    my($in, $out) = @$_;

    is capture("perl perl/ch-1.pl $in"), $out;
    is capture(        "c/ch-1    $in"), $out;
    is capture(      "cpp/ch-1    $in"), $out;
}

for (["opt bat saw tab pot top was" => <<END],
[ ("opt", "pot", "top"),
  ("bat", "tab"),
  ("saw", "was") ]
END
     ["x" => <<END]) {
[ ("x") ]
END
    my($in, $out) = @$_;

    is capture("python python/ch-1.py $in"), $out;
    is capture( "gforth forth/ch-1.fs $in"), $out;
    is capture(        "basic/ch-1    $in"), $out;
}


compile("gcc -o c/ch-2       c/ch-2.c");
compile("g++ -o cpp/ch-2   cpp/ch-2.cpp");
compile("fbc             basic/ch-2.bas");


for ([<<'END' => "1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3"],
        1
       / \
      2   3
     / \
    4   5
       / \
      6   7
END
     [<<'END' => "7 -> 5 -> 4 -> 6 -> 8 -> 9"]) {
        7
       / \
      5   8
     / \   \
    4   6   9
END
    my($in, $out) = @$_;
    path($input)->spew($in);

    is capture(    "perl perl/ch-2.pl < $input"),  "$out\n";
    is capture("python python/ch-2.py < $input"),  "$out\n";
    is capture( "gforth forth/ch-2.fs < $input"),  "$out\n";
    is capture(            "c/ch-2    < $input"),  "$out\n";
    is capture(          "cpp/ch-2    < $input"),  "$out\n";
    is capture(        "basic/ch-2    < $input"),  "$out\n";
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
