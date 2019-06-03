#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use experimental 'switch';

sub usage {
    print <<"-USAGE-";
    Usage:
    $0 -f <number>
    $0 -t <number>

    -f          convert Roman numerals to a decimal number
    -t          convert a number (between 1 and 3000) to Roman numerals
    <number>    the number to convert
-USAGE-
    exit(1);
}

sub fromRoman {
    my ($number) = @_;
    my $result;

    while () {
        given ($number) {
            when (/\GMMM/gc) { $result += 3000; }
            when (/\GMM/gc)  { $result += 2000; }
            when (/\GM/gc)   { $result += 1000; }

            when (/\GCM/gc)   { $result += 900; }
            when (/\GDCCC/gc) { $result += 800; }
            when (/\GDCC/gc)  { $result += 700; }
            when (/\GDC/gc)   { $result += 600; }
            when (/\GD/gc)    { $result += 500; }
            when (/\GCD/gc)   { $result += 400; }
            when (/\GCCC/gc)  { $result += 300; }
            when (/\GCC/gc)   { $result += 200; }
            when (/\GC/gc)    { $result += 100; }

            when (/\GXC/gc)   { $result += 90; }
            when (/\GLXXX/gc) { $result += 80; }
            when (/\GLXX/gc)  { $result += 70; }
            when (/\GLX/gc)   { $result += 60; }
            when (/\GL/gc)    { $result += 50; }
            when (/\GXL/gc)   { $result += 40; }
            when (/\GXXX/gc)  { $result += 30; }
            when (/\GXX/gc)   { $result += 20; }
            when (/\GX/gc)    { $result += 10; }

            when (/\GIX/gc)   { $result += 9; }
            when (/\GVIII/gc) { $result += 8; }
            when (/\GVII/gc)  { $result += 7; }
            when (/\GVI/gc)   { $result += 6; }
            when (/\GV/gc)    { $result += 5; }
            when (/\GIV/gc)   { $result += 4; }
            when (/\GIII/gc)  { $result += 3; }
            when (/\GII/gc)   { $result += 2; }
            when (/\GI/gc)    { $result += 1; }

            when (/\G$/gc)    { last; }
            default           { $result = 0; last; } # some unexpected input
        }
    }
    return $result;
}

sub toRoman {
    my ($number) = @_;

    if ($number < 1 || $number > 3000) {
        usage();
    }

    my $result;

    given ($number / 1000 % 10) {
        when (1) { $result .= 'M'; }
        when (2) { $result .= 'MM'; }
        when (3) { $result .= 'MMM'; }
        default {}
    }

    given ($number / 100 % 10) {
        when (1) { $result .= 'C'; }
        when (2) { $result .= 'CC'; }
        when (3) { $result .= 'CCC'; }
        when (4) { $result .= 'CD'; }
        when (5) { $result .= 'D'; }
        when (6) { $result .= 'DC'; }
        when (7) { $result .= 'DCC'; }
        when (8) { $result .= 'DCCC'; }
        when (9) { $result .= 'CM'; }
        default {}
    }

    given ($number / 10 % 10) {
        when (1) { $result .= 'X'; }
        when (2) { $result .= 'XX'; }
        when (3) { $result .= 'XXX'; }
        when (4) { $result .= 'XL'; }
        when (5) { $result .= 'L'; }
        when (6) { $result .= 'LX'; }
        when (7) { $result .= 'LXX'; }
        when (8) { $result .= 'LXXX'; }
        when (9) { $result .= 'XC'; }
        default {}
    }

    given ($number % 10) {
        when (1) { $result .= 'I'; }
        when (2) { $result .= 'II'; }
        when (3) { $result .= 'III'; }
        when (4) { $result .= 'IV'; }
        when (5) { $result .= 'V'; }
        when (6) { $result .= 'VI'; }
        when (7) { $result .= 'VII'; }
        when (8) { $result .= 'VIII'; }
        when (9) { $result .= 'IX'; }
        default {}
    }

    return $result;
}

if (scalar @ARGV < 2) {
   usage();
}

if ($ARGV[0] eq '-f') {
   say fromRoman($ARGV[1]);
} elsif ($ARGV[0] eq '-t') {
   say toRoman($ARGV[1]);
} else {
   usage();
}