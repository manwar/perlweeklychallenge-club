#!/usr/bin/perl
use v5.38;

my ($str1, $str2) = @ARGV;

undef while ($str1 =~ s/[^#]#//);
undef while ($str2 =~ s/[^#]#//);

say $str1 eq $str2 ? 'true' : 'false';
