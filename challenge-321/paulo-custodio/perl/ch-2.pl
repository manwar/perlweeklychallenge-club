#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";
my($str1, $str2) = @ARGV;
for ($str1, $str2) {
    1 while s/[^#]#//;
}
say $str1 eq $str2 ? "true" : "false";
