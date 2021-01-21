#!/usr/bin/env perl

use strict;
use warnings;
use 5.030;
use Test::More;

compile(         "gcc     c/ch-1.c   -o     c/ch-1");
compile(         "g++   cpp/ch-1.cpp -o   cpp/ch-1");
compile(         "fbc basic/ch-1.bas -o basic/ch-1");

for (["The Weekly Challenge" => "Challenge Weekly The"],
	 ["'    Perl and   Raku are  part of the same family  '" => 
								"family same the of part are Raku and Perl"]) {
	my($in, $out) = @$_;
	
	is capture(    "perl perl/ch-1.pl $in"), "$out\n";
	is capture("python python/ch-1.py $in"), "$out\n";
	is capture( "gforth forth/ch-1.fs $in"), "$out\n";
	is capture(            "c/ch-1    $in"), "$out\n";
	is capture(          "cpp/ch-1    $in"), "$out\n";
	is capture(        "basic/ch-1    $in"), "$out\n";
}


is capture("perl perl/ch-2a.pl kitten sitting"), 	"3\n";
is capture("perl perl/ch-2a.pl sunday monday"), 	"2\n";

compile("gcc     c/ch-2.c   -o     c/ch-2");
compile("g++   cpp/ch-2.cpp -o   cpp/ch-2");
compile("fbc basic/ch-2.bas -o basic/ch-2");

for (["kitten sitting" => <<END],
3
Operation 1: replace 'k' with 's'
Operation 2: replace 'e' with 'i'
Operation 3: insert 'g' at end
END
     ["sunday monday" => <<END]) {
2
Operation 1: replace 's' with 'm'
Operation 2: replace 'u' with 'o'
END
	my($in, $out) = @$_;
	
	is capture(    "perl perl/ch-2.pl $in"), $out;
	is capture("python python/ch-2.py $in"), $out;
	is capture( "gforth forth/ch-2.fs $in"), $out;
	is capture(            "c/ch-2    $in"), $out;
	is capture(          "cpp/ch-2    $in"), $out;
	is capture(        "basic/ch-2    $in"), $out;
}

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
