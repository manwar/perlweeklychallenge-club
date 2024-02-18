#!/usr/bin/perl
use 5.030;
use warnings;

my $arg = join q{}, @ARGV;
$arg =~ s/10/b/g;
$arg =~ s/11/c/g;
$arg =~ s/0/a/g;
say $arg =~ /a$/ ? 1 : 0;
