#!/usr/bin/env perl

# Perl Weekly Challenge 288 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-288/

use Modern::Perl;

my $SEEN = ' ';

sub parse_matrix {
    my(@m) = @_;
    @m = map {[split //, $_]} @m;
    return @m;
}

sub size_block {
    my($m, $ch, $r, $c) = @_;
    $m->[$r][$c] = $SEEN;
    my $count = 1;
    if ($r-1 >= 0 && $m->[$r-1][$c] eq $ch) {
        $count += size_block($m, $ch, $r-1, $c);
    }
    if ($r+1 < @$m && $m->[$r+1][$c] eq $ch) {
        $count += size_block($m, $ch, $r+1, $c);
    }
    if ($c-1 >= 0 && $m->[$r][$c-1] eq $ch) {
        $count += size_block($m, $ch, $r, $c-1);
    }
    if ($c+1 < @{$m->[0]} && $m->[$r][$c+1] eq $ch) {
        $count += size_block($m, $ch, $r, $c+1);
    }
    return $count;
}

sub max_block {
    my(@m) = @_;
    my $max_block = 0;
    for my $r (0 .. @m-1) {
        for my $c (0 .. @{$m[0]}-1) {
            next if $m[$r][$c] eq $SEEN;
            my $block = size_block(\@m, $m[$r][$c], $r, $c);
            if ($block > $max_block) {
                $max_block = $block;
            }
        }
    }
    return $max_block;
}

my @m = parse_matrix(@ARGV);
my $max_block = max_block(@m);
say $max_block;
