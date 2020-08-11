#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw(combinations);

my $count = $ARGV[0] // 2;
die "ERROR: Invalid count $count.\n"
    unless (($count >= 1) && ($count <= 5));

my $chars = [qw(a e i o u)];

if ($count == 1) {
    print join "\n", @$chars;
    print "\n";
    exit;
}

my $iter = combinations($chars, $count);

my $char_sets = [];
while (my $char = $iter->next) {
    push @$char_sets, join "", @$char;
}

my $rules = [
    qr/a(?=[ie])/,
    qr/e(?=[i])/,
    qr/i(?=[aeou])/,
    qr/o(?=[au])/,
    qr/u(?=[oe])/
];

foreach my $char_set (@$char_sets) {
    my $pass = 0;
    foreach my $rule (@$rules) {
        if ($char_set =~ /$rule/) {
            $pass = 1;
        }
    }
    print "$char_set\n" if ($pass);
}
