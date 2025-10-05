#!/usr/bin/perl
use 5.038;
use warnings;

my @bits = @ARGV;
my $arg = join q{}, @ARGV;

$arg =~ s/10/b/g;
$arg =~ s/11/c/g;
$arg =~ s/0/a/g;

say $arg =~ /a$/ ? 1 : 0;
