#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ first };

my @dirs = qw{ dir_a dir_b dir_c };
@dirs = sort @ARGV if @ARGV;
my $maxcol = 0;

my %files;
for my $dir (@dirs) {
    $maxcol = length $dir if length $dir > $maxcol;
    next unless -d $dir;
    my @nodes = glob "$dir/*";
    for my $n (@nodes) {
        my ($node) = reverse split m{/}, $n;
        $node .= '/' if -d $n;
        $files{$node}{$dir} = 1;
        $maxcol = length $node if length $node > $maxcol;
    }
}

say show_row( $maxcol, @dirs );
say show_row( $maxcol, map { '-' x $maxcol } @dirs );
for my $file ( sort keys %files ) {
    say show_row( $maxcol,
        map { defined $files{$file}{$_} ? $file : '' } @dirs );
}

sub show_row ( $maxcol, @row ) {
    return join ' | ', map { pad( $_, $maxcol ) } @row;
}

sub pad ( $word, $maxcol ) {
    my $pad = ' ' x ( $maxcol - length $word );
    return join '', $word, $pad;
}
