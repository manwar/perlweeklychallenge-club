#!/usr/bin/perl
use warnings;
use strict;

use Template;

my $HELP = << '__HELP__';
Usage: $0 input_file [width height]

Use - for input_file to read standard input.
Width and height default to 400x300.
__HELP__

my $TEMPLATE = << '__SVG__';
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="[% height %]" width="[% width %]" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
[% IF lines -%]
    <g id="lines" stroke="#369" stroke-width="4">
    [%- FOREACH line IN lines %]
        <line x1="[% line.0 %]" x2="[% line.2 %]" y1="[% line.1 %]" y2="[% line.3 %]" />
    [%- END %]
    </g>
[% END- %]
[%- IF points -%]
    <g fill="#f73" id="points">
    [%- FOREACH point IN points %]
        <circle cx="[% point.0 %]" cy="[% point.1 %]" r="3" />
    [%- END %]
    </g>
[%- END %]
</svg>
__SVG__

my $file = shift;
if (! defined $file || $file =~ /^(?:-h|--help)$/) {
    print $HELP;
    exit ! defined $file
}

my $width  = shift || 400;
my $height = shift || 300;

my ($min_x, $max_x, $min_y, $max_y);
my (@points, @lines);
my $FLOAT = qr/-?(?:[0-9]*(?:\.[0-9]+)?+)/;

my $in;
if ('-' eq $file) {
    $in = *STDIN;
} else {
    open $in, '<', $file or die "$file: $!";
}

while (<$in>) {
    if (/^($FLOAT),($FLOAT),($FLOAT),($FLOAT)$/) {
        my ($x0, $y0, $x1, $y1) = ($1, $2, $3, $4);
        push @lines, [$x0, $y0, $x1, $y1];
        for my $x ($x0, $x1) {
            $min_x = $x if ! defined $min_x || $x < $min_x;
            $max_x = $x if ! defined $max_x || $x > $max_x;
        }
        for my $y ($y0, $y1) {
            $min_y = $y if ! defined $min_y || $y < $min_y;
            $max_y = $y if ! defined $max_y || $y > $max_y;
        }

    } elsif (/^($FLOAT),($FLOAT)$/) {
        my ($x, $y) = ($1, $2);
        push @points, [$x, $y];
        $min_x = $x if ! defined $min_x || $x < $min_x;
        $max_x = $x if ! defined $max_x || $x > $max_x;
        $min_y = $y if ! defined $min_y || $y < $min_y;
        $max_y = $y if ! defined $max_y || $y > $max_y;

    } else {
        warn "WARN: Ignoring: $_";
    }
}

my $scale_x = ($max_x - $min_x) / $width;
my $scale_y = ($max_y - $min_y) / $height;
$_ ||= 1 for $scale_x, $scale_y;

for my $point (@points) {
    $point->[0] = ($point->[0] - $min_x) / $scale_x;
    $point->[1] = ($point->[1] - $min_y) / $scale_y;
}
for my $line (@lines) {
    $line->[$_] = ($line->[$_] - $min_x) / $scale_x for 0, 2;
    $line->[$_] = ($line->[$_] - $min_y) / $scale_y for 1, 3;
}

my $template = 'Template'->new;
$template->process(\$TEMPLATE,
                   {height => $height,
                    width  => $width,
                    points => \@points,
                    lines  => \@lines}
) or die $template->error;

__DATA__
53,10
53,10,23,30
23,30
