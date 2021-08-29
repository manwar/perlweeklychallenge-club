#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @grid = (
    "x * * * x * x x x x",
    "* * * * * * * * * x",
    "* * * * x * x * x *",
    "* * * x x * * * * *",
    "x * * * x * * * * x"
);

print("Input:\n");
foreach(@grid){
    print("    $_\n");
}
print("\nOutput:\n");
foreach(mark_minefield_counts(@grid)){
    print("    $_\n");
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Mark a minefield grid with the number of mines adjacent to each non-mine
# cell
# Takes one argument:
# * An array of strings that describe a grid, with 'x' representing mined
#   cells, and '*' representing non-mined cells, e.g.:
#   (
#       "x * * * * x",
#       "* * * * x *",
#       "* x * * * x"
#   )
#   Note that all the strings must be the same length
# Returns:
# * A copy of the minefield grid, with the non-mine cells marked with the
#   number of mines adjacent to each, e.g.:
#   (
#       "x 1 0 1 2 x",
#       "2 2 1 1 x 3",
#       "1 x 1 1 2 x"
#   )
################################################################################
sub mark_minefield_counts{
    my @grid = @_;

    my $h;
    my $w;
    my $i;
    my $j;

    $h = scalar(@grid);

    # Eliminate spaces, change un-mined
    # cells to zeros, and break each line
    # into its component characters
    $j = $h;
    while($j--){
        $grid[$j] =~ s/ //g;
        $grid[$j] =~ s/\*/0/g;
        $grid[$j] = [split('', $grid[$j])];
    }

    $w = scalar(@{$grid[0]});

    # Wander the grid in an orderly fashion
    $j = $h;
    while($j--){
        $i = $w;
        while($i--){
            # There are probably fewer mines than
            # not-mines, so look for mines
            if($grid[$j][$i] eq 'x'){
                # This cell has a mine- examine adjacent
                # cells within the bounds of the grid
                for my $y (($j ? $j-1 : 0) .. ($j+1-$h ? $j+1 : $j)){
                    for my $x (($i ? $i-1 : 0) .. ($i+1-$w ? $i+1 : $i)){
                        # Increment the adjacent cell at
                        # $x, $y unless it has a mine
                        $grid[$y][$x]++
                            unless($grid[$y][$x] eq 'x');
                    }
                }
            } # end if($grid[$j][$i] eq 'x')
        }
    }

    # Reconstitute the grid's original spacing
    $j = $h;
    while($j--){
        $grid[$j] = join(" ", @{$grid[$j]});
    }

    return(@grid);

}



