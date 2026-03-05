#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "Usage: $0 STR\n";

my $str = uc(shift);
$str =~ s/(.)\1*/$1/g;
say length($str)-1;
