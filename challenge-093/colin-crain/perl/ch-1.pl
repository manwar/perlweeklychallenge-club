#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       acme.pl
#
#         TASK #1 › Max Points
#         Submitted by: Mohammad S Anwar
#         You are given set of co-ordinates @N.
#
#         Write a script to count maximum points on a straight line when given
#         co-ordinates plotted on 2-d plane.
#
#         Example 1:
#         |
#         |     x
#         |   x
#         | x
#         + _ _ _ _
#
#         Input: (1,1), (2,2), (3,3)
#         Output: 3
#         Example 2:
#         |
#         |
#         | x       x
#         |   x
#         | x   x
#         + _ _ _ _ _
#
#         Input: (1,1), (2,2), (3,1), (1,3), (5,3)
#         Output: 3

#         method:
#             Two points determine a line. Thus between every two points given a
#             line segment can be scribed, which can be extended infinitely in
#             both directions to determine the line it falls on. Our task is to
#             see how many of these infinite lines overlap, and are in fact the
#             same line.

#             At it's heart this is a problem of combinatorics, of combinations
#             of two points. A single point can be determined to either fall or
#             not on a given line, but we first need a line to check, and the
#             only way to find those is to look at pairs of points.

#             In fact, if we're going to look at every pair anyways, we already
#             have all the information we need to derive a solution. For every
#             pair, use those points to determine a line segment AB with
#             endpoints (x1, y1) and (x2, y2). This segment will fall on exactly
#             one infinite line of the form y = mx + b, with m being the slope
#             of the line and b an offset on the y-axis.

#             To calculate the slope and constant of the through line from the
#             pairs of points we calculate the delta for the ys over the delta
#             for the xs. The offset will be the same for both points, so we can
#             use either to calculate b:
#
#             m = (y2-y1) / (x2-x1)
#
#             b = y1 - m * x1

#             Once we have a pair of coefficiants (m,b), these can be turned
#             into a unique hash key. Unfortuantely this is complicated by the
#             limitations of floating point arithmetic over the value of the
#             slope, so we'll devise a purpose-built stringification routine to
#             ensure equivalent slopes get the same hash key. It doesn't matter
#             what the key actually is, only that it be a unique mapping.
#





#
#       2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use Algorithm::Combinatorics qw( combinations );
use List::Util qw( max );
use POSIX qw( ceil );

## ## ## ## ## MAIN:

my $RANDOM = 1000;     ## set to sub in random number of data points

## input array is aggregated point pairs: 1, 1, 2, 2, 3, 4 -> (1,1,) (2,2) (3,4)
my @input = @ARGV;
my @points;
my %lines;
my %l2;
my %line_lookup;
my ($x, $y);
while (@input > 0) {
    ($x, $y, @input) = @input;
    push @points, [$x, $y];
}


if ($RANDOM) { @points = random_points($RANDOM) } ;

## make combinations of points and hash line coefficients between them
my $iter = combinations( \@points, 2 );
while ( my $c = $iter->next ) {
    my $line = get_line($c);
    my $key = make_hashkey($line);
    $lines{$key}++;                     ## the simple counting hash
    push $l2{$key}->@*, $c;             ## added: keeps track of point pairs instead
    $line_lookup{$key} = $line;         ## added: xref to remember line coordinates for output
}

## output header
if ($RANDOM) {
    say "random selection of $RANDOM points in a $RANDOM x $RANDOM point space";
}
else {
    say "points input: ", join ', ', map { "[$_[0],$_[1]]" } @points;
}
say '';

## calculate the simple solution
my $max = max( values %lines );
say "binomial is $max";
say "quantity is ", reverse_binomial( 2 * $max );



## added: create a more detailed report
## (warning: data structure is deeper than it looks. Use floatation devices. No lifeguard on duty.)
my %inline;
my ($k, $v);
while  ( ($k,$v) = each %l2 ) {
    if (scalar(@$v) == $max) {          ## found the maximum
        for my $c (@$v) {
            for my $p (@$c) {
                my ($s, $t) = @$p;
                $inline{ "${s}_${t}" } = $p;
            }
        }
        last;
    }
}

say "points are: ";
say "[ $inline{$_}->@* ]" for sort {    $inline{$a}->[0] <=> $inline{$b}->[0]
                                     || $inline{$a}->[1] <=> $inline{$b}->[1]  } keys %inline;

say '';
if ($line_lookup{$k}->[0] == "Inf") {
    say "line is x = $line_lookup{$k}->[3]";
}
else {
    say "line is y = ", $line_lookup{$k}->[0], " x + ", $line_lookup{$k}->[1];
}

## ## ## ## ## SUBS:

sub get_line {
    my $combo = shift;
    my ($p1, $p2) = $combo->@*;
    my ($m, $b, $n, $c);
    if ( ($p2->[0] - $p1->[0]) == 0 ) {
        ($m, $b) = ("Inf",0) ;
    }
    else {
        $m = ($p2->[1]-$p1->[1]) / ($p2->[0]-$p1->[0]);
        $b = $p1->[1] - ($m * $p1->[0]);
    }
    if ( ($p2->[1] - $p1->[1]) == 0 ) {
        ($n, $c) = ("Inf",0)
    }
    else {
        $n =  ($p2->[0]-$p1->[0]) / ($p2->[1]-$p1->[1]);
        $c = $p1->[0] - ($n * $p1->[1]);
    }
    return [$m, $b, $n, $c];
}

sub make_hashkey {
    my $quad = shift;
    my $key = sprintf "%.11e_%.11e_%.11e_%.11e", @$quad;
    return $key;
}

sub reverse_binomial {
    use POSIX qw(ceil);
    my $b = shift;
    return ceil(sqrt $b);
}

sub random_points {
## any set of points can be transformed into the x, y > 0 quadrant so we'll
## just start there
    my $range = $_[0];
    my $count = $_[0];
    my @out;

    for (1..$count) {
        my $x = int(rand($count)+1);
        my $y = int(rand($count)+1);
        push @out, [$x, $y];
    }

    return @out;
}
