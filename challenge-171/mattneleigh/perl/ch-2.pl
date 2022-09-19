#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $h = compose(
    sub{

        # Point out each argument and return
        # a list with attention drawn to each
        return(map("->".$_."<-", @ARG));

    },
    sub{

        # Multiply every argument by two and
        # return them all as a list
        return(map($_ * 2, @ARG));

    }
);
my @values = (1, 2, 3, 4, 5);

printf(
    "\nInput:  %s\nOutput: %s\n\n",
    join(", ", @values),
    join(", ", &$h(@values))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Generate a subroutine that makes nested calls to two other supplied
# subroutines
# Takes two arguments:
# * A code ref to the outer sub to call, f
# * A code ref to the inner sub to call, g
# Returns:
# * A ref to a new sub h(...) that calls f(g(...))
################################################################################
sub compose{
    my $f = shift();
    my $g = shift();

    return(
        sub{

            # This @ARG is the one passed to
            # the sub, not to compose()
            return(&$f(&$g(@ARG)));

        }
    );

}



