#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @args = (
    # Specified mileage grid
    [
        [0, 5, 2, 7],
        [5, 0, 5, 3],
        [3, 1, 0, 6],
        [4, 5, 4, 0]
    ],

    # Extra credit- large random mileage grids
    # of 15x15 and 20x20
    create_random_grid(15, 9),
    create_random_grid(20, 9)
);
my $itinerary;
my $grid;

foreach $grid (@args){
    print_mileage_grid($grid);
    $itinerary = plan_sales_route($grid, 0);
    printf("length = %d\ttour = (%s)\n",
        $itinerary->[0], join(" ", @{$itinerary->[1]})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Produce a salesperson's travel itinerary and compute the total distance
# traveled
# Takes two arguments:
# * A reference to a grid (2D array of dimensions NxN; N need not be specified
#   here) of mileages between cities
# * The index of the city in which the salesperson is to begin (and end) their
#   tour
# Returns:
# * A ref to an array whose first element is the total distance to be traveled,
#   and whose second element is a ref to an array of indicies, taken from the
#   supplied grid of cities to be visited, that describes the calculated
#   itinerary, e.g.:
#   $itinerary = [ 10, [0, 2, 1, 3, 0] ]
################################################################################
sub plan_sales_route{
    my $grid = shift();
    my $start = shift();

    my $i;
    my $j;
    my @visited;
    my $distance;
    my $city;
    my $itinerary = [
        0,
        []
    ];

    # Initialize a few things
    $j = scalar(@{$grid->[0]});
    $i = $j - 1;
    while($j--){
        $visited[$j] = 0;
    }

    # Start at the specified city- add
    # the city to the tour itinerary and
    # mark it as having been visited
    push(@{$itinerary->[1]}, $start);
    $visited[$start] = 1;

    # Take a tour of predetermined length
    while($i--){
        # Presumably no city will be a
        # million miles away...
        $distance = 1000000;
        $city = 0;

        # Check all the cities we can get to
        # from the current city
        for($j=0; $j<scalar(@{$grid->[0]}); $j++){
            # Skip this potential next city if
            # we've visited already
            next if($visited[$j]);

            if($grid->[$itinerary->[1][-1]][$j] < $distance){
                # The mileage to this city is lower
                # than any previously examined
                # segment; make a note of it
                $distance = $grid->[$itinerary->[1][-1]][$j];
                $city = $j;
            }
        }

        # Add mileage from the next segment to
        # the total, add details of the next
        # segment to the itinerary, and mark
        # the next city as visited
        $itinerary->[0] += $distance;
        push(@{$itinerary->[1]}, $city);
        $visited[$city] = 1;
    }
    
    # Return to the specified city: add the
    # mileage between the last city visited
    # and the origin city, and put the
    # origin city in the tour itinerary again
    $itinerary->[0] += $grid->[
        $itinerary->[1][-1]
        ]
        [$start];
    push(@{$itinerary->[1]}, $start);

    return($itinerary);

}



################################################################################
# Create a random mileage grid
# Takes two arguments:
# * The number of cities to include in the grid (N)
# * The maximum distance allowed between any two cities
# Returns:
# * A ref to a populated mileage grid- a 2D array with dimensions NxN
################################################################################
sub create_random_grid{
    my $n = shift();
    my $max = shift();

    my $grid;
    my $i;
    my $j;

    $max = int($max);

    # Loop over both coordinates; this makes
    # heavy (ab)use of autovivification
    $i = $n;
    while($i--){
        $j = $n;
        while($j--){
            # If the two coordinates are equal,
            # store zero, otherwise store a random
            # (but nonzero) integer
            $grid->[$i][$j] = $i == $j ? 0 : int(rand($max)) + 1;
        }
    }

    return($grid);

}



################################################################################
# Print the contents of a mileage grid to STDOUT
# Takes one argument:
# * A reference to a mileage grid (2D array of dimensions NxN; N need not be
#   specified here)
# Returns:
# * The same mileage grid reference passed as the argument, in case the caller
#   wishes to produce output en passant while creating grids
################################################################################
sub print_mileage_grid{
    my $grid = shift();

    my $i;

    print("[\n");
    for($i=0; $i<scalar(@{$grid}); $i++){
        printf(
            "    [ %s ]%s\n",
            join(", ", @{$grid->[$i]}),
            $i == $#{$grid} ? "" : ","
        );
    }
    print("]\n");

    return($grid);

}



