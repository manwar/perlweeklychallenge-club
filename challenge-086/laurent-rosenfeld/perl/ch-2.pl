use strict;
use warnings;
use feature "say";
use constant MAX => 8;

my @grid =
    ( [ qw < _ _ _ 2 6 _ 7 _ 1 > ],
      [ qw < 6 8 _ _ 7 _ _ 9 _ > ],
      [ qw < 1 9 _ _ _ 4 5 _ _ > ],
      [ qw < 8 2 _ 1 _ _ _ 4 _ > ],
      [ qw < _ _ 4 6 _ 2 9 _ _ > ],
      [ qw < _ 5 _ _ _ 3 _ 2 8 > ],
      [ qw < _ _ 9 3 2 _ _ 7 4 > ],
      [ qw < _ 4 _ _ 5 _ _ 3 6 > ],
      [ qw < 7 _ 3 _ 1 8 _ _ _ > ]
    );

# Replaces _ with 0 and numify values
for my $line (@grid) {
    for my $item (@$line) {
        $item = $item eq '_' ? 0 : +$item;
    }
}
say "[ @$_ ]" for @grid; say "";

my %square;
for my $i (0..MAX) {
    $square{$i} = $i <= 2 ? [0..2] :
                  $i >= 6 ? [6..8] :
                  [3..5];
}

sub is_allowed_digit {
    my ($grid_ref, $k, $position_ref) = @_;
    my @grid = @$grid_ref;
    my ($i, $j) = @$position_ref;
    return 0 if grep $_ == $k, @{$grid[$i]};       # line
    for my $n (0..MAX) {                           # column
        return 0 if $k == $grid[$n][$j];
    }
    for my $m (@{$square{$i}}) {                   # Square
        return 0 if grep { $k == $grid[$m][$_] } @{$square{$j}};
    }
    return 1;
}

my $solution_found = 0;
my $continue = 1;
while ($continue) {
    my $one_change_made = 0;
    my $no_hole_left = 1;
    for my $row (0..MAX) {
        for my $col (0..MAX) {
            next if $grid[$row][$col];
            my @candidates;
            for my $candidate (1..9) {
                push @candidates, $candidate if
                    is_allowed_digit(\@grid, $candidate, [$row, $col]);
            }
            if (@candidates == 1) {
                $grid[$row][$col] = $candidates[0];
                $one_change_made = 1;
            } else {
                $no_hole_left = 0;
            }
        }
    }
    # say "[ @$_ ]" for @grid;  say "";
    $solution_found = $no_hole_left;
    $continue = (! $no_hole_left) && $one_change_made;
}
if ($solution_found) {
say "Solution:";
    say "[ @$_ ]" for @grid;
} else {
    brute_force_find(@grid, 0);
}

sub brute_force_find {
    my @grid = @$_[0];
    my $row_id = $_[1];
    for my $i (0..MAX) {
        my $hole = (grep {$grid[$i][$_] == 0} 0..8)[0];
        unless (defined $hole) {
            if ($i == MAX) {
                # We've found a solution (no hole, last row)
                say "[ @$_ ]" for @grid;
                return;
            } else {
                next; # No hole, process next row
            }
        }
        my $found_candidate = 0;
        for my $k (1..9) {
            if (is_allowed_digit(@grid, $k, [$i, $hole])) {
                $grid[$i][$hole] = $k;
                $found_candidate = 1;
                brute_force_find(@grid, $i);
            }
        }
        # we are in a deadend if we did not find any suitable candidate
        # for the hole. Backtracking is needed.
        return unless $found_candidate;
    }
}
