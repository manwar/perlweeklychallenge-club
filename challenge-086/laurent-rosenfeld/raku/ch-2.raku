use v6;

constant MAX = 8;
my @grid =
    [ < _ _ _ 2 6 _ 7 _ 1 > ],
    [ < 6 8 _ _ 7 _ _ 9 _ > ],
    [ < 1 9 _ _ _ 4 5 _ _ > ],
    [ < 8 2 _ 1 _ _ _ 4 _ > ],
    [ < _ _ 4 6 _ 2 9 _ _ > ],
    [ < _ 5 _ _ _ 3 _ 2 8 > ],
    [ < _ _ 9 3 2 _ _ 7 4 > ],
    [ < _ 4 _ _ 5 _ _ 3 6 > ],
    [ < 7 _ 3 _ 1 8 _ _ _ > ];

# Replaces _ with 0 and numify values
for @grid <-> $line {
    for @$line <-> $item {
        $item = $item eq '_' ?? 0 !! +$item;
    }
}
.say for @grid; say "";
my %square;
for 0..MAX {
    when 0..2 { %square{$_} = |(0..2)}
    when 3..5 { %square{$_} = |(3..5)}
    when 6..8 { %square{$_} = |(6..8)}
}

sub is-allowed-digit (@grid, Int $k, $position) {
    my ($i, $j) = $position[0, 1];
    return False if $k == @grid[$i].any;         # line
    for 0..MAX -> $n {                           # column
        return False if $k == @grid[$n][$j];
    }
    for %square{$i} -> $m {                      # Square
        return False if $k == (@grid[$m][|%square{$j}]).any;
    }
    True;
}

my $solution-found = False;
my $continue = True;
while $continue {
    my $one-change-made = False;
    my $no-hole-left = True;;
    for 0..MAX -> $row {
        for 0..MAX -> $col {
            next if @grid[$row][$col];
            # $no-hole-left = False;
            my @candidates = gather {
                for 1..9 -> $candidate {
                    take $candidate if
                        is-allowed-digit @grid, $candidate, [$row, $col];
                }
            }
            if @candidates.elems == 1 {
                @grid[$row][$col] = @candidates[0];
                $one-change-made = True;
            } else {
                $no-hole-left = False;
            }
        }
    }
    # .say for @grid;  say ""; # uncomment to see the progress on each iteration
    $solution-found = $no-hole-left;
    $continue = (! $no-hole-left) && $one-change-made;
}
if $solution-found {
say "Solution:";
    .say for @grid;
} else {
    brute-force-find(@grid, 0);
}

sub brute-force-find (@grid is copy, Int $row-id) {
     for 0..MAX -> $i {
        my $hole = (grep {@grid[$i][$_] == 0}, 0..8)[0];
        unless defined $hole {
            if $i == MAX {
                # We've found a solution (no hole, last row)
                .say for @grid;
                return;
            } else {
                next; # No hole, process next row
            }
        }
        my $found_candidate = False;
        for 1..9 -> $k {
            if is-allowed-digit(@grid, $k, [$i, $hole]) {
                @grid[$i][$hole] = $k;
                $found_candidate = True;
                brute-force-find(@grid, $i);
            }
        }
        # we are in a deadend if we did not find any suitable candidate
        # for the hole. Backtracking needed
        return unless $found_candidate;
    }
}
