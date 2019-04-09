#!/usr/bin/env perl
#
# Filename: base35.pl
#
# Usage:
#   perl base35.pl [+-]NUMBER FROM-BASE, e.g.
#
#   perl base35.pl 1000 10
#     Output: SK
#
#   perl base35.pl SK 35
#     Output: 1000
#
#   perl base35.pl -SK 35
#     Output: -1000
use v5.18;
say base35_conv(@ARGV);
sub base35_conv {
    my ($no, $base) = (uc(shift), shift);
    if ($base != 10 && $base != 35) {
        warn "Not a valid base, must be 10 or 35";
        return -1;
    }
    if (($base == 35 && $no !~ /^[\+\-]{0,1}[0-9A-Y]+$/) || ($base == 10 && $no !~ /^[\+\-]{0,1}[0-9]+$/)) {
        warn "You have to provide a valid number for the given base";
        return -1;
    }
    my ($c, $e) = (0, 0);
    my $prefix = $no =~ s/^(\+|-)// ? $1 : "";
    my %d = map { if ($base == 35) { $_ => $c++ } else { $c++ => $_  } } (0..9,'A'..'Y');
    if ($base == 35) {
        my $i = 1;
        for (reverse(split("", $no))) {
            $e += $i * $d{$_};
            $i = $i * 35;
        }
    }
    else {
        my @digits;
        while ($no > 0) {
            push @digits, $d{$no % 35};
            $no = int($no / 35);
        }
        $e = join("", reverse(@digits));
    }
    return ( $prefix ? $prefix : "" ) . $e;
}


