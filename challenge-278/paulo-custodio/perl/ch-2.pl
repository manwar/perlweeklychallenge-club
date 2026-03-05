#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "Usage: $0 word letter\n";
my($word, $letter) = @ARGV;

say $word =~ s{.*?$letter}{ join '', sort split //, $& }er;
