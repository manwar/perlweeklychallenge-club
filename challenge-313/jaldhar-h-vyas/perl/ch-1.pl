#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

sub breakup($str) {
    my $i = 0;
    return grep { $_ if $i++ % 2 == 0 } ($str =~ /((.)\2*)/g);
}

my ($name, $typed) = @ARGV;
my @nameParts = breakup($name);
my @typedParts = breakup($typed);
my $result = true;

for my $i (0 .. scalar @nameParts - 1) {
    unless ($typedParts[$i] =~ /$nameParts[$i]/) {
        $result = false;
        last;
    } 
}

say $result ? "true" : "false";