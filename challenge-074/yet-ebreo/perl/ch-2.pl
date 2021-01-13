#! /usr/bin/perl
use strict;
use warnings;
use feature 'say';


my $p;
for my $c (($ARGV[0] || "ababc") =~ /./g) {
    $p .= $c;
    1 while $p=~s/(.)(.*)\1/$2/;
    print ((substr $p,-1) || "#");

}