use strict;
use warnings;

# Main function to check if the string exists in the grid
sub exists_in_grid {
    my ($grid, $str) = @_;
    my $rows = @$grid;
    my $cols = @{$grid->[0]};
    my $len = length($str);

    # Directions: up, down, left, right
    my @directions = ([-1, 0], [1, 0], [0, -1], [0, 1]);

    # Helper function for depth-first search (DFS)
    sub dfs {
        my ($x, $y, $index) = @_;
        
        # If we've matched the entire string, return true
        return 1 if $index == $len;
        
        # Save the original character to restore later
        my $original = $grid->[$x][$y];
        
        # Mark the current cell as visited by setting it to an invalid character
        $grid->[$x][$y] = ' ';  # Mark as visited (temporarily with a space)
        
        # Explore all four directions (up, down, left, right)
        for my $dir (@directions) {
            my ($dx, $dy) = @$dir;
            my $nx = $x + $dx;
            my $ny = $y + $dy;

            # Check if the new position is valid and matches the next character in the string
            if ($nx >= 0 && $nx < $rows && $ny >= 0 && $ny < $cols && $grid->[$nx][$ny] eq substr($str, $index, 1)) {
                # Recurse into the next position
                if (dfs($nx, $ny, $index + 1)) {
                    return 1;
                }
            }
        }

        # Restore the original value (backtrack)
        $grid->[$x][$y] = $original;
        return 0;
    }

    # Iterate over the grid to find the starting point
    for my $i (0..$rows-1) {
        for my $j (0..$cols-1) {
            if ($grid->[$i][$j] eq substr($str, 0, 1)) {
                # If the first character matches, start DFS
                if (dfs($i, $j, 1)) {
                    return 1;
                }
            }
        }
    }

    return 0;
}

# Test case 1
my @chars1 = (['A', 'B', 'D', 'E'],
              ['C', 'B', 'C', 'A'],
              ['B', 'A', 'A', 'D'],
              ['D', 'B', 'B', 'C']);
my $str1 = 'BDCA';
print exists_in_grid(\@chars1, $str1) ? "true\n" : "false\n";  # Output: true

# Test case 2
my @chars2 = (['A', 'A', 'B', 'B'],
              ['C', 'C', 'B', 'A'],
              ['C', 'A', 'A', 'A'],
              ['B', 'B', 'B', 'B']);
my $str2 = 'ABAC';
print exists_in_grid(\@chars2, $str2) ? "true\n" : "false\n";  # Output: false

# Test case 3 (Fixed)
my @chars3 = (['B', 'A', 'B', 'A'],
              ['C', 'C', 'C', 'C'],
              ['A', 'B', 'A', 'B'],
              ['B', 'B', 'A', 'A']);
my $str3 = 'CCCAA';
print exists_in_grid(\@chars3, $str3) ? "true\n" : "false\n";  # Output: true