#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(uniq);

@ARGV==1 or die "usage: $0 str\n";
my $str = $ARGV[0];
1 while $str =~ s/\D\d//;
say $str;
