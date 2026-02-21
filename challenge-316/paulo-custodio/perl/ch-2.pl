#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 str1 str2\n";

my($str1, $str2) = @ARGV;
my $rx = join ".*", split //, $str1;
say $str2 =~ /$rx/ ? "true" : "false";
