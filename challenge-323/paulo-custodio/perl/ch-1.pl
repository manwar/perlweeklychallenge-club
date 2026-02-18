#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 ops\n";
my $ops = "@ARGV";
my $total = (($ops =~ tr/+/+/) - ($ops =~ tr/-/-/)) / 2;
say $total;
