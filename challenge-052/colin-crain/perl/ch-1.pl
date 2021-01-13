#! /opt/local/bin/perl
#
#       stepping.pl
#
#       TASK #1
#         Stepping Numbers
#             Write a script to accept two numbers between 100 and 999. It
#             should then print all Stepping Numbers between them.
#
#             A number is called a stepping number if the adjacent digits have a
#             difference of 1. For example, 456 is a stepping number but 129 is
#             not.
#
#         method: another example of what I have begun to call problems in
#             "Concrete Number Theory"; where the objectives are not merely
#             placed in the relationships between values in the solutions, but
#             in the physical way that these numbers are represented on a page.
#
#             In this example we do not care so much as to what a number
#             represents, but rather whether its adjectant digits differ by 1.
#             It is not restricted that the difference should be either ascending or
#             descending or even consistant, thus we shall conclude not only
#             that 123 fits the bill and also 654 and 656.
#
#             Adjecent digits can be extracted arithmatically using division by
#             10 and integer rounding. Sure, why not? It's not exactly SpaceX
#             stuff. But why go through that trouble when we can apply text
#             processing to the number represented as a string? In Perl all we
#             need do is look at a number like a string, using a string function
#             for example, and a string pointer will be created and stored
#             alongside the integer value with the scalar and be available to do
#             string stuff forever after. Ahh, Perlguts. The good stuff.
#
#             For the record, Perlguts is demonstratively more fun than
#             spongiform encephalopathy, albeit often producing the same
#             effects. It is good to have a basic understanding of what's behind
#             the curtain though. Usually the number contained within a scalar
#             and the string representing that number appear identical. With the
#             interpreter silently switching behind the scenes, it is not
#             unreasonable that the casual user might think of them as being the
#             same physical data, read different ways, but they are not.
#             Normally updating one or another of these values triggers an
#             update of the other, but this is not necesaariy the case.
#
#             The stringified component of a scalar can even be a completely
#             different thing: in the $! scalar, the string component holds a
#             nice descriptive phrase, but the integer component holds a related
#             but structurally very different error number. The two components
#             need not even be related in any way, although getting this to
#             happen requires some pretty gruesome under the hood tinkering. For
#             the adventurous, the Scalar::Util module provides a dualvar()
#             function that will construct such arbitrary scalars. For most
#             users it's good just to understand that a Perl scalar is in fact a
#             rather complicated struct, comprised of many interconnected data
#             fields, keeping track of namespaces, reference counts, reference
#             blessing and many other relevant and changing pieces of information tuned to
#             exactly what that particular scalar happens to be being used for.
#
#             But back to treating numbers as strings. We can do this in Perl,
#             so we should. It's dead simple to dice a string into a list of
#             parts using split //. Once we have divided a number into three
#             separate digits, comparing the first to the second, and the second
#             to the third, will give us our answer. Wrapping this logic in a
#             subroutine comparmentalizes it nicely. Again, we don't care what
#             the digits represent. We only care about the logic of the
#             relationships, so this function only returns 1 for success and 0
#             for failure.
#
#             Feeding this function to grep {} creates a filter. Sorting the
#             commandline inputs allows us to make a range to filter. The valid
#             cases that pass through are printed out, one per line.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ($low, $high) = sort {$a <=> $b} @ARGV;

my @output = grep { stepping($_) } ($low..$high);

say for @output;


## ## ## ## ## SUBS:

sub stepping {
    my $num = shift;
    my ($a, $b, $c) = split //, $num;
    abs( $a - $b ) == 1 && abs( $b - $c ) == 1 ? 1 : 0;
}
