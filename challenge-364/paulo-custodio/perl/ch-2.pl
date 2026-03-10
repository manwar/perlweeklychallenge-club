#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
$_ = shift;
s/\(\)/o/g;
s/\(al\)/al/g;
say $_;
