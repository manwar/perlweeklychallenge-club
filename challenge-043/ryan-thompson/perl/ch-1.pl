#!/usr/bin/env perl
#
# perl5/ch-1.pl - Olympic rings
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw< sum all any none notall first >;
use Time::HiRes qw< sleep >;

my ($W, $H) = (70, 30);
my $ch = '#'; # Character to use for the rings

# Color table. Could use Term::ANSIColor for this, but escape codes are easy
my %col = (
    r => "\e[0;31m", g => "\e[0;32m",   k => "\e[1;30m",
    y => "\e[0;33m", b => "\e[0;34m", RST => "\e[0m",
    given => {   brace => "\e[0;36m", num => "\e[1;36m" },
    solve => {   brace => "\e[0;32m", num => "\e[1;32m" },
    try   => {   brace => "\e[0;35m", num => "\e[1;35m" },
);

# Brace semantics for numbers
my %brace = (
    given => { left => '<', right => '>' },
    solve => { left => '[', right => ']' },
    try   => { left => '{', right => '}' },
);

# I've opted for a bitmapped approach. This will get converted to ANSI by
# render()
my $bitmap = [ map { [ (' ') x $W ] } 1..$H ];

# Default options
my %o = (render => 1, delay => 0.10, ar => 0.66, r => 10, bitmap => $bitmap);

# Draw the rings!
circle(%o, x => 11, y => 11, col => 'r');
circle(%o, x => 22, y => 18, col => 'g');
circle(%o, x => 33, y => 11, col => 'k');
circle(%o, x => 44, y => 18, col => 'y');
circle(%o, x => 55, y => 11, col => 'b');

# Put the given numbers on the bitmap
num(given => 9, 11, 11);
num(given => 5, 22, 18);
num(given => 7, 44, 18);
num(given => 8, 55, 11);

# Problem definition. Givens and avail are from description.
my %sol = map { $_ => 0 } qw<rg gk k ky yb>;
my %given; @given{qw<r g y b>} = (9, 5, 7, 8); # Givens
my @avail = (1..4, 6); # Numbers available

my @order_try = grep { exists $sol{$_} } qw<r rg g gk k ky y yb b>;

# Solution
update(try => \%sol);

say "\e[2J"; # CLRSCR
render();

# Now solve the puzzle, step by step
%sol = solve(%sol);

update(solve => \%sol);
render();

say "Solution: " . join ', ', map { "$_: $sol{$_}" } @order_try;

# Solve the puzzle, step by step, and optionally render it
# The puzzle is solved if solved() is true
sub solve {
    my (%sol) = @_;
    if ($o{render}) {
        update(try => \%sol);
        render();
        sleep $o{delay};
    }
    my $check = check_sol(\%sol);
    return %sol if $check eq 'solved';
    return      if $check eq 'impossible';

    # Get list of numbers still available
    my %solR = reverse %sol; # keys <-> values
    my @rem  = grep { not exists $solR{$_} } @avail;

    my $spot = first { $sol{$_} == 0 } @order_try;
    for my $num (@rem) {
        my %new = solve(%sol, $spot => $num);
        return %new if keys %new; # Pass back solution
    }

    return;
}

# Check a solution. Three possibilities:
#       solved: This is a valid solution
#   impossible: Solution has at least one sum != 11, so we can prune here
#     possible: Solution contains only unknowns or sums == 11
sub check_sol {
    my $sol = shift;
    my @sums = map {
        sum map {
            $sol->{$_} || $given{$_} || -100;
        } split '+';
    } qw<r+rg rg+g+gk gk+k+ky ky+y+yb yb+b>;

    return   (all { $_ == 11           } @sums) ?     'solved'
        : (notall { $_ == 11 || $_ < 0 } @sums) ? 'impossible'
        :                                           'possible';
}

# Update the fields on the bitmap for the %sol. Use "try" or "solve" for $type
sub update {
    my ($type, $sol) = @_;
    num($type => $sol->{rg} // 0, 16, 14);
    num($type => $sol->{gk} // 0, 28, 14);
    num($type => $sol->{k}  // 0, 33, 11);
    num($type => $sol->{ky} // 0, 38, 14);
    num($type => $sol->{yb} // 0, 50, 14);
}

# Render a "frame" by converting @$bitmap to ANSI and printing it to screen.
sub render {
    # Convert bitmap to lines
    my $text = join "\n", map { join '', @$_ } @$bitmap;

    # Now colorize it, as if by magic
    $text =~ s/(([a-z])\1*)/$col{$2} . $ch x length($1) . $col{RST}/megi;
    $text =~ s/ <(\d)> / num_col( given => $1 ) /emgx;
    $text =~ s/\[(\d)\]/ num_col( solve => $1 ) /emgx;
    $text =~ s/ {(\d|\?)} / num_col( try   => $1 ) /emgx;
    say "\e[H$text";
}

# Colorize a number placed with num
sub num_col {
    my ($type, $num) = @_;
    "$col{$type}{brace}\[$col{$type}{num}$num$col{$type}{brace}\]$col{RST}";
}

# Place a number on the board of the given type (given, try, or solve)
sub num {
    my ($type, $num, $x, $y) = @_;
    $bitmap->[$y][$x] = $num || '?';
    $bitmap->[$y][$x-1] = $brace{$type}{left};
    $bitmap->[$y][$x+1] = $brace{$type}{right}
}

# Midpoint circle algorithm
# https://en.wikipedia.org/wiki/Midpoint_circle_algorithm
sub circle {
    my %o = @_;
    my $f = 1 - $o{r};
    my $ddF_x = 0;
    my $ddF_y = -2 * $o{r};
    my ($x, $y) = (0, $o{r});

    # Set a "pixel" to the specified color, offset by $x0, $y0
    my $pix; $pix = sub {
        my ($x, $y, $stop) = @_;
        $pix->($y,$x,1) unless $stop;
        $y *= $o{ar};
        $o{bitmap}[ $o{y} + $y ][ $o{x} + $x ] = $o{col};
        $o{bitmap}[ $o{y} + $y ][ $o{x} - $x ] = $o{col};
        $o{bitmap}[ $o{y} - $y ][ $o{x} + $x ] = $o{col};
        $o{bitmap}[ $o{y} - $y ][ $o{x} - $x ] = $o{col};
    };

    $pix->(0,  $o{r});
    $pix->(0, -$o{r});
    while ($x < $y) {
        if ($f >= 0) {
            $ddF_y += 2;
            $f     += $ddF_y;
            $y     -= 1;
        }
        $x     += 1;
        $ddF_x += 2;
        $f     += $ddF_x + 1;
        $pix->($x, $y);
    }
}
