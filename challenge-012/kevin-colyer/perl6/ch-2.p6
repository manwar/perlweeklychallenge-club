#!/usr/bin/perl6
use v6;

use Test;

my @input=("/a/b/c/d", "/a/b/cd", "/a/b/cc", "/a/b/c/d/e");
my $output="/a/b";
my $sep="/";

is shortestCDP(@input,$sep),$output,"Test of shortestCDP";
is shortestCDP(("/a/b/c/d", "/a/b/cd", "/a/cc", "/a/b/c/d/e"),$sep),"/a","Test of shortestCDP";
is shortestCDP(("/a/b/c/d", "/a/b/c", "/a/b/c/d/e"),$sep),"/a/b/c","Test of shortestCDP";

done-testing;

say "12.2) shortest path is " ~  shortestCDP(@input,$sep);


sub shortestCDP(@input, $sep) {
    my $l=@input[0].chars;
    my @dirs;
    for @input -> $i {
        my $d=[$i.split($sep, :skip-empty)];
        $l=min($l, $d.elems);
        @dirs.push($d);
    }
    my @found;
    my $i=0;
    while $i < $l {
        my $alleq=True;
        for @dirs -> $d {
            next if $d[$i] eq @dirs[0][$i];
$alleq=False;
            last;;
       }
        $i++;
        next if $alleq==False;
        @found.push(@dirs[0][$i-1]);
    }
    return $sep ~ @found.join($sep);
}

