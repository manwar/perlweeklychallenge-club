#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

use Carp;
use JSON;
my $json = JSON->new->pretty->canonical;

my $all = all_excel();
my $lla->%* = reverse $all->%*;

my %alpha = map { state $c = 0; $c++ => $_ } 'A' .. 'Z';
my %ahpla = reverse %alpha;

for my $i ( sort { $a <=> $b } 1 .. 40, 100, 1000, 10000 ) {
    my $e   = to_excel_col1($i);
    my $r   = from_excel_col1($e);
    my $ch1 = $all->{$i};
    my $ch2 = $lla->{$e};
    say join "\t", '--', $i, $e, $r, '', $ch1, $ch2;
}

# first row is different, because instructions assume
# we start with row 1, but things become so much easier
# with a zero index
sub to_excel_col1 ( $i, $f = 0 ) {
    $i = int $i;
    croak 'out of range' if $i < 0 || $i > 16384;
    croak 'out of range' if $i == 0 && $f == 0;
    $i -= 1 unless $f;

    my $mod = $i % 26;
    my $num = int $i / 26;
    my $l   = $f ? $alpha{ $mod - 1 } : $alpha{$mod};

    return join '', to_excel_col1( $num, 1 ), $l if $num > 0;
    return $l;
}

sub from_excel_col1 ( $c, $f = 0 ) {
    $c =~ s/\W//g;
    $c = uc $c;
    my @c = split //, $c;
    my $o = 0;
    my $l = pop @c;
    my $v = $ahpla{$l};
    !$f && $v++;
    $o += $v;

    if ( scalar @c ) {
        my $d = join '', @c;
        my $e = from_excel_col1( $d, 1 );
        $o += 26 * ( 1 + $e );
    }
    return $o;
}

sub all_excel () {
    my $done   = {};
    my $output = {};
    my $key    = 1;
    for my $i ( '', 'A' .. 'Z' ) {
        for my $j ( '', 'A' .. 'Z' ) {
            for my $k ( 'A' .. 'Z' ) {
                my $col = join '', $i, $j, $k;
                next if $done->{$col}++;

                # say join ' ', $col, $key;
                $output->{$key} = $col;
                $key++;
            }
        }
    }

    # exit;
    return $output;
}
