#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub matrix_score($m) {
    my $height = @$m;
    my $width  = @{ $m->[0] };
    my $ser    = serialise($m);
    my %agenda = my %done = ($ser => undef);
    my $max    = score($ser, $width);

    while (%agenda) {
        my %next;
        for my $s (keys %agenda) {
            for my $i (0 .. ($width, $height)[$width < $height] - 1) {
                my @flips;
                push @flips, flip_col($s, $i, $width, $height) if $i < $width;
                push @flips, flip_row($s, $i, $width, $height) if $i < $height;
                for my $f (@flips) {
                    unless (exists $done{$f}) {
                        my $score = score($f, $width);
                        $max = $score if $score > $max;
                        undef $next{$f};
                        undef $done{$f};
                    }
                }
            }
        }
        %agenda = %next;
    }
    return $max
}

sub serialise($m) { join "", map @$_, map @$_, @_ }

sub flip_col($s, $x, $width, $height) {
    for my $y (0 .. $height - 1) {
        my $pos = $x + $y * $width;
        substr $s, $pos, 1, substr($s, $pos, 1) ? 0 : 1;
    }
    return $s
}
sub flip_row($s, $y, $width, $height) {
    my $pos = $y * $width;
    for my $x (0 .. $width - 1) {
        substr $s, $pos, 1, substr($s, $pos, 1) ? 0 : 1;
        ++$pos;
    }
    return $s
}

sub score($s, $width) {
    my $score = 0;
    my $pos   = 0;
    while (length(my $row = substr $s, $pos, $width)) {
        $score += oct "0b$row";
    } continue {
        $pos += $width;
    }
    return $score
}

use Test::More tests => 3 + 2;

is score('111110011111', 4), 39, 'score';
is flip_col('001110', 1, 3, 2), '011100', 'flip column';
is flip_row('001110', 1, 3, 2), '001001', 'flip row';

is matrix_score([ [0,0,1,1],
                  [1,0,1,0],
                  [1,1,0,0], ]), 39, 'Example 1';

is matrix_score([ [0] ]), 1, 'Example 2';
