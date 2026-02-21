#!/usr/bin/env perl

use Modern::Perl;

my $str = shift // "";
$str =~ tr/[a-z][A-Z]/[A-Z][a-z]/;
say $str;
