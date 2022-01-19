#!perl.exe

use strict;
use warnings;
use List::MoreUtils qw ( uniq );

### Challenge #145  Palindromic Tree
### Author --- Robert DiCicco
### Date --- 27-DEC-2021

my $str = $ARGV[0];

my @results = ();
for my $i ( 0 .. (length($str) - 1)){
    my $search = substr($str, $i, 1);
    my $start = index($str, $search);
    my $end = index($str, $search, $start + 1);

    if($end == -1){
        push(@results, $search);
        next;
    }

    my $s = substr($str, $start, $end - $start + 1);
    if($s eq reverse($s)){
        push(@results, "$search" . " $s");
    } else {
        push(@results, $search);
    }

    @results = uniq(@results);
}

foreach(@results){
    print("$_ ");
}

print("\n");
