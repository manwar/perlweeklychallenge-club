#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ _no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <Point1> <Point2> <Point3> -- a point is a pair of integers separated by a comma
-USAGE-
    exit 0;
}

sub area {
    my ($p1, $p2, $p3) = @_;

    return abs( 
        (
            $p1->[0] * ($p2->[1] - $p3->[1]) +
            $p2->[0] * ($p3->[1] - $p1->[1]) +
            $p3->[0] * ($p1->[1] - $p2->[1])
        ) / 2.0
    );
}

sub isInside {
    my ($a, $b, $c, $p) = @_;

    my $area0 = area($a, $b, $c);
    my $area1 = area($p, $b, $c);
    my $area2 = area($a, $p, $c);
    my $area3 = area($a, $b, $p);

    return ($area0 == $area1 + $area2 + $area3);
}

if (scalar @ARGV != 3) {
    usage;
}

my $pointrx = qr/\A (-*\d+) \, (-*\d+) \z /msx;

$ARGV[0] =~ /$pointrx/;
my @a = ($1, $2);

$ARGV[1] =~ /$pointrx/;
my @b = ($1, $2);

$ARGV[2] =~ /$pointrx/;
my @c = ($1, $2);

my @p = (0, 0);

say isInside(\@a, \@b, \@c, \@p) ? 1 : 0;