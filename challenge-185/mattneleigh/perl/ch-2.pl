#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @codes = (
    # Given cases
    [
        [ "ab-cde-123", "123.abc.420", "3abc-0010.xy" ],
        0
    ],
    [
        [ "1234567.a",  "a-1234-bc",   "a.b.c.d.e.f" ],
        0
    ],

    # Additional test cases
    [
        [ "CPE-1704-TKS", "NX-2000", "867-5309" ],
        0
    ],
    [
        [ "CPE-1704-TKS", "NX-2000", "867-5309" ],
        1
    ]
);

print("\n");
foreach my $code_list (@codes){
    printf(
        "Input: \@list = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "'$_'",
                @{$code_list->[0]}
            )
        ),
        join(
            ", ",
            map(
                "'".mask_alphanumerics($_, 4, $code_list->[1])."'",
                @{$code_list->[0]}
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Mask the first N alphanumeric characters (i.e. a-z, A-Z, 0-9) from either end
# of a string, replacing them with 'x'
# Takes three arguments:
# * The string to examine (e.g. "a.b.c.d.e.f")
# * The number N of appropriate characters to mask (e.g. 4)
# * The direction in which to operate: if this argument is false or omitted,
#   mask characters from the beginning of the string; if it is true, operate
#   from the end of the string
# Returns:
# * The modified string, with the appropriate N alphanumerics masked (e.g.
#   "x.x.x.x.e.f")
################################################################################
sub mask_alphanumerics{
    my $code = shift();
    my $num = shift();
    my $direction = shift();

    # Don't include 'x' in the character class(es)
    # here- we'd just replace it with a new 'x'
    # anyway, but we also don't want to match
    # things we've already replaced
    if($direction){
        # Operate on the end of the string
        while($num--){
            # This isn't pretty, but it works
            $code =~ s/[0-9A-Za-wy-z]{1}([^0-9A-Za-wy-z]{0,})$/x/;
            $code .= $1
                if(length($1));
        }
    } else{
        # Operate on the beginning of the string
        while($num--){
            $code =~ s/[0-9A-Za-wy-z]/x/;
        }
    }

    return($code);

}



