#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @coupon_code_sets = (
    [
        [ "A123", "B_456", "C789", "D\@1", "E123" ],
        [ "electronics", "restaurant", "electronics", "pharmacy", "grocery" ],
        [ "true", "false", "true", "true", "true" ]
    ],
    [
        [ "Z_9", "AB_12", "G01", "X99", "test" ],
        [ "pharmacy", "electronics", "grocery", "electronics", "unknown" ],
        [ "true", "true", "false", "true", "true" ]
    ],
    [
        [ "_123", "123", "", "Coupon_A", "Alpha" ],
        [ "restaurant", "electronics", "electronics", "pharmacy", "grocery" ],
        [ "true", "true", "false", "true", "true" ]
    ],
    [
        [ "ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4" ],
        [ "electronics", "electronics", "grocery", "grocery" ],
        [ "true", "true", "true", "true" ]
    ],
    [
        [ "CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99" ],
        [ "restaurant", "electronics", "grocery", "pharmacy", "electronics" ],
        [ "true", "true", "true", "true", "false" ]
    ]
);

# Some additional details
my %valid_names = (
    electronics => 1,
    grocery => 1,
    pharmacy => 1,
    restaurant => 1
);

print("\n");
foreach my $coupon_codes (@coupon_code_sets){
    printf(
        "Input: \@codes  = (%s)\n       \@names  = (%s)\n"
        .
        "       \@status = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$coupon_codes->[0]}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$coupon_codes->[1]}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$coupon_codes->[2]}
            )
        ),
        join(
            ", ",
            map(
                $_ ? "true" : "false",
                validate_codes($coupon_codes, \%valid_names)
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a set of parallel arrays defining a set of codes, names, and statuses
# associated with coupons, determine which coupons are valid and which are not;
# valid codes consist only of the characters A-Z, a-z, 0-9, and _; valid names
# must be present in a specified set of name values (see below); valid codes
# have a status value of 'true'
# Takes two arguments:
# * A ref to an array of three parallel arrays, each corresponding respectively
#   to the codes, names, and statuses of the coupons to examine (e.g.
#       [
#           [ "A123", "B_456", "C789", "D@1", "E123" ],
#           [ "electronics", "restaurant", "electronics",
#               "pharmacy", "grocery" ],
#           [ "true", "false", "true", "true", "true" ]
#       ]
#   )
# * A ref to a hash that acts as a set of valid name values (e.g.
#       {
#           electronics => 1,
#           grocery     => 1,
#           pharmacy    => 1,
#           restaurant  => 1
#       )
#   )
# Returns:
# * A list of ones (1) and zeros (0) corresponding to the validity of each
#   coupon, with one indicating a valid coupon and zero indicating an invalid
#   coupon (e.g. (1, 0, 1, 0, 1) )
################################################################################
sub validate_codes{
    my ($codes, $names, $status) = @{shift()};
    my $valid_names = shift();

    return(
        # Build a list of 0's and 1's indicating whether
        # each item has valid data according to established
        # criteria; tests arranged in order of increasing
        # computational complexity
        map(
            (
                # Reject codes that are zero-lengh
                !length($codes->[$_])
                ||
                # Reject items with a false status
                ($status->[$_] eq "false")
                ||
                # Reject names that are not in the validity table
                !$valid_names->{$names->[$_]}
                ||
                # Reject codes that contain invalid characters
                $codes->[$_] =~ m/[^A-Za-z0-9_]/
            ) ?
                0
                :
                1,
            0 .. $#$codes
        )
    );

}



