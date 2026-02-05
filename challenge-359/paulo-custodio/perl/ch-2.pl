#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage:$0 str\n";
my $str = $ARGV[0];
1 while $str =~ s/(.)\1//;
say $str;
