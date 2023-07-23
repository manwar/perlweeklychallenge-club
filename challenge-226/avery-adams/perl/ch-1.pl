#!/usr/bin/perl

use v5.36;

my $string = shift;
my @indices = @ARGV;
my @chars = split //, $string;
my %table;

die "Mismatch in numbers" unless $#indices == $#chars;
foreach (0 .. $#chars) {
    $table{$indices[$_]} = $chars[$_];
}
foreach (0 .. $#chars) {
    print $table{$_};
}
print "\n";
