#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @route_maps = (
    [ ["B","C"], ["D","B"], ["C","A"] ],
    [ ["A","Z"] ]
);

print("\n");
foreach my $route_map (@route_maps){
    my $rval = determine_final_destination($route_map);

    printf(
        "Input: \@routes = (%s)\nOutput: \"%s\"\n\n",
        join(
            ", ",
            map(
                "[" . join(", ", map("\"" . $_ . "\"", @{$_})) . "]",
                @{$route_map}
            )
        ),
        defined($rval) ?
            $rval
            :
            "None"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of routes, defined in terms of start and end points, determine
# whether there is a point beyond which no route departs, and if so, report
# the name of that point
# Takes one argument:
# * A ref to a list of routes, each of which is itself an array consisting of a
#   starting point and end point (e.g.
#       [
#           ["B","C"],
#           ["D","B"],
#           ["C","A"]
#       ]
#   )
# Returns on success:
# * The first destination point, in the order the waypoints are presented in
#   the input, that does not have a route departing from it (e.g. "A" )
# Returns on error:
# * undef if no route was found to have an endpoint from which no other route
#   departs
################################################################################
sub determine_final_destination{
    my $routes = shift();

    my %origins;

    # Store a table of all origin points
    foreach my $route (@{$routes}){
        $origins{$route->[0]} = 1;
    }

    # Scan each destination to see if it's also an
    # origin point; if we find one that isn't,
    # return it
    foreach my $route (@{$routes}){
        return($route->[1])
            unless($origins{$route->[1]});
    }

    # Got here- every destination had connections
    # to further points
    return(undef);

}



