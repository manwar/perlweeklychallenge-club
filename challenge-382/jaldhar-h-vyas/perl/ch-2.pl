#!/usr/bin/perl
use 5.40.1;
use strict;
use warnings;

sub generate($prefix, $index, $chars, $combinations) {

    if ($index == @{$chars}) {
        push @{$combinations}, $prefix;
        return;
    }

    my $char = $chars->[$index];

    if ($char eq '?') {
        generate($prefix . '0', $index + 1, $chars, $combinations);
        generate($prefix . '1', $index + 1, $chars, $combinations);
    }
    else {
        generate($prefix . $char, $index + 1, $chars, $combinations);
    }
}

my ($str) = @ARGV;

my @chars = split //, $str;
my @combinations;

generate('', 0, \@chars, \@combinations);

say q{(}, (join q{, }, map { "\"$_\"" } @combinations), q{)};