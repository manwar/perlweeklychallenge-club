#!/usr/bin/env perl

use Modern::Perl;

my $str = shift // "";
$str =~ s/\|[^|]*\|//g;
my $count = $str =~ tr/*/*/;
say $count;
