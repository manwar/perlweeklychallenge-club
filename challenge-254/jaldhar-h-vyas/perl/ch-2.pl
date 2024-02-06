#!/usr/bin/perl
use 5.030;
use warnings;

my ($s) = @ARGV;

my @chars = split //, $s;
my @vowels;

for my $c (keys @chars) {
    if ($chars[$c] =~ /[aAeEiIoOuU]/) {
        push @vowels, $chars[$c];
    }
}

for my $c (keys @chars) {
    if ($chars[$c] =~ /[AEIOU]/) {
        $chars[$c] = uc pop @vowels;
    }
    elsif ($chars[$c] =~ /[aeiou]/) {
        $chars[$c] = lc pop @vowels;
    }
}

say join q{}, @chars;
