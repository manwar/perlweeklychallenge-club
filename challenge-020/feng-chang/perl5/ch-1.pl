#!/bin/env perl

use Modern::Perl;

die "usage: $0 <string>\n" unless $ARGV[0];

say 'Solution 1:';
{
    my @a;
    my $last_char = '';
    my $s = '';
    for my $c (split //, $ARGV[0]) {
        if ($c eq $last_char) {
            $s .= $c;
        } else {
            push(@a, $s) if $s;
            $s = $last_char = $c;
        }
    }
    push(@a, $s) if $s;

    say join ' ', @a;
}

say 'Solution 2:';
{
    my @a;
    my $i = 1;
    for my $s ($ARGV[0] =~ m/((.)\2*)/g) {
        push(@a, $s) if $i;
        $i = 1 - $i;
    }

    say join ' ', @a;
}
