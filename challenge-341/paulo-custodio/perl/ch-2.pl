#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 word letter\n";
my($word, $letter) = @ARGV;
$word =~ s/(.*?$letter)/reverse $1/e;
say $word;
