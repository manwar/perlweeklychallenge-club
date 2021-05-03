#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub transpose_file {
    my ($input, $output) = @_;
    open my $in,  '<', $input  or die $!;
    open my $out, '>', $output or die $!;

    my $maybe_comma = "";
    my @tr;
    while (<$in>) {
        chomp;
        my @cells = split /,/;
        $tr[$_] .= "$maybe_comma$cells[$_]" for 0 .. $#cells;
        $maybe_comma = ',';
    }
    say {$out} $_ for @tr;
}

use Test::More tests => 1;

my $file = << '__INPUT__';
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
__INPUT__

my $expected = << '__EXPECTED__';
name,Mohammad,Joe,Julie,Cristina
age,45,20,35,10
sex,m,m,f,f
__EXPECTED__

transpose_file(\$file, \ my $outfile);
is $outfile, $expected;
