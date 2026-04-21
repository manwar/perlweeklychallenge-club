#!/usr/bin/perl
use strict;
use warnings;

sub fun_sort {

    my ($list) = @_;

    my @even = sort { $a <=> $b } grep { $_ % 2 == 0 } @$list;
    my @odd  = sort { $a <=> $b } grep { $_ % 2 == 1 } @$list;

    my @res = (@even, @odd);
    return @res;
}

# Alternative
# Explanation:

# The two bracketed expressions produce array references:
# [ sort { $a <=> $b } grep { $_ % 2 == 0 } @$list ] -> arrayref of sorted evens
# [ sort { $a <=> $b } grep { $_ % 2 == 1 } @$list ] -> arrayref of sorted odds
# map { @$_ } ( ... ) iterates over that list of arrayrefs. For each arrayref ($),
# @$ dereferences it to the underlying list; map then returns those lists
# concatenated (flattened) into a single list. So @res gets the flattened result:
# the sorted evens followed by the sorted odds.

sub fun_sort_alt {

    my ($list) = @_;
    my @res  = map { @$_ }
                   ( [ sort { $a <=> $b } grep { $_ % 2 == 0 } @$list ],
                     [ sort { $a <=> $b } grep { $_ % 2 == 1 } @$list ]
                   );
    return @res;
}

# Tests

my @list;

# Example 1
@list = (1, 4, 3, 2, 6, 5);
print "(", join(", ", fun_sort(\@list)), ")\n"; # Output: (2, 4, 6, 1, 3, 5)

# Example 2
@list = (1,2)
print "(", join(", ", fun_sort(\@list)), ")\n"; # Output: (2,1)

# Example 3
@list = (1)
print "(", join(", ", fun_sort(\@list)), ")\n"; # Output: (1)
