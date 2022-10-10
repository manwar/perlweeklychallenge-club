#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @a = qw/ 1 2 3 /;
my @b = qw/ a b c /;

print("\n");
print("\@a = qw/", join(" ", @a), "/;\n");
print("\@b = qw/", join(" ", @b), "/;\n");
print("\n");
print("zip(\\\@a, \\\@b) returns qw/", join(" ", zip(\@a, \@b)), "/;\n");
print("zip(\\\@b, \\\@a) returns qw/", join(" ", zip(\@b, \@a)), "/;\n");
print("\n");

# Now this is just silly...
print(
    "zip([ zip(\\\@a, \\\@b) ], [ zip(\\\@b, \\\@a) ]) returns qw/",
    join(" ", zip([ zip(\@a, \@b) ], [ zip(\@b, \@a) ])),
    "/;\n"
);
print(
    "zip([ zip(\\\@b, \\\@a) ], [ zip(\\\@a, \\\@b) ]) returns qw/",
    join(" ", zip([ zip(\@b, \@a) ], [ zip(\@a, \@b) ])),
    "/;\n"
);
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Merge two lists into one, taking one element from each in turn until all
# elements are copied into the new list.  The lists need not be the same
# length.
# Takes two arguments:
# * A reference to the first list (e.g. [ 1, 2, 3 ])
# * A reference to the second list (e.g. [ a, b, c ])
# Returns:
# * The merged list (e.g. ( 1, a, 2, b, 3, c ))
# NOTE: The original lists are NOT altered
################################################################################
sub zip{
    # Create copies of the lists referred to in our
    # arguments
    my @a = @{shift()};
    my @b = @{shift()};

    my @c;

    # Loop while there's something left in either list
    while(@a || @b){
        # Strip the first remaining element, if any, from
        # each supplied list, and push it into the merged
        # list
        push(@c, shift(@a))
            if(@a);
        push(@c, shift(@b))
            if(@b);
    }

    return(@c);
    
}



