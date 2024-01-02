#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [ "perl", "2", "000", "python", "r4ku" ],
    [ "001", "1", "000", "0001" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@alphanumstr = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$word_list}
            )
        ),
        maximum_alphanumeric_string_value(@{$word_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of alphanumeric strings, determine the highest alphanumeric
# "value" among them, where "value" is defined as the number described by the
# string if it consists solely of digits, OR the length of the string, in
# characters
# Takes one argument:
# * The list of strings to examine (e.g
#       ( "perl", "2", "000", "python", "r4ku" )
#   )
# Returns:
# * The largest numerical "value" of any string in the list, as defined above
#   (e.g. 6 )
################################################################################
sub maximum_alphanumeric_string_value{
    use List::Util qw(max);

    return(
        max(
            map(
                {
                    if(m/\D/){
                        # String has non-digits...
                        # Compute its length
                        length($_);
                    } else{
                        # String only has digits...
                        # Copy the string so we can modify
                        # it without affecting @ARG
                        my $str = $_;

                        # Strip leading zeros
                        $str =~ s/^0+//;

                        if(length($str)){
                            # Digits remain
                            $str;
                        } else{
                            # String had only zeros
                            0;
                        }
                    }
                }
                @ARG
            )
        )
    );

}



