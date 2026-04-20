#!/usr/bin/perl
use 5.038;
use warnings;

my ($caption) = @ARGV;

my @words = split /\s+/, $caption;
my $result =  (lc $words[0]) . join q{}, map { ucfirst $_ } @words[1 .. $#words]; 
$result = q{#} . $result =~ s/[^A-Za-z]//gr;
say length $result <= 100 ? $result : substr($result, 0, 100);  
