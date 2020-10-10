#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use List::Util 1.39 qw(pairs);

sub usage {
    say 'perl ch-1.pl # no option: reading from a file named `input\'';
}

my @f_ARGV = grep { ! /-(h|-*help)/ } @ARGV;
@f_ARGV == @ARGV or usage, exit 0;

my ( $file_path, @words ) = "input";
-r $file_path or usage, exit 0;

open my $fh, '<', $file_path or die $@;

{
    local $/ = undef;
    @words = split /\s/, <$fh>;
};

# filtering and add to bag
my %prada;
for my $w (@words) {
    $w =~ s/'s|--|[^a-zA-Z_0-9\-]//g;
    ++$prada{$w};
}

# invert frequency and word
my %evilWares;
for my $pair ( pairs %prada ) {
    push @{$evilWares{$pair->value}}, $pair->key;
}

for my $freq ( sort ( keys %evilWares ) ) {
    say "$freq @{[sort @{$evilWares{$freq}}]}";
}
