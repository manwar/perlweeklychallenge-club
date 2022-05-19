#!/usr/bin/env perl
#
# ch-1.pl - SVG
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use Getopt::Long;
use SVG;

my %o = (height => 300, width => 400, credits => 1,
    'line-color' => '#369', 'point-color' => '#f73', radius => 3,
    'stroke-width' => 4);
GetOptions(\%o, qw< height=i width=i credits! line-color=s point-color=s
                    radius=f stroke-width=f >) or die "Usage: $0 [options]";

# Ingest points and lines with some basic error handling. Feed to plot_svg()
say plot_svg(map {
    my @n = split /[\s,]+/;

    my $err = sub { die "Error at input line $.: $_[0], input was:\n  $_\n" };
    $err->('Not a number')                 if grep { /[^0-9.-]/ } @n;
    $err->('Expected 2- or 4-number list') if @n != 2 and @n != 4;

    [ @n ];
} <> );

# Do the actual SVG plot
sub plot_svg {
    my $svg = SVG->new(width => $o{width}, height => $o{height},
        $o{credits} ? () : (-nocredits => 1));

    # Style the points and lines
    my $lg = $svg->group(           id => 'lines', 
                        'stroke-width' => $o{'stroke-width'},
                                stroke => $o{'line-color'});

    my $pg = $svg->group(           id => 'points',
                                  fill => $o{'point-color'});

    # Plot points and lines
    for (@_) {
        $lg->line(  x1 => $_->[0], y1 => $_->[1], 
                    x2 => $_->[2], y2 => $_->[3])                 if @$_ == 4;
        $pg->circle(cx => $_->[0], cy => $_->[1],r => $o{radius}) if @$_ == 2;
    }

    $svg->xmlify;
}
