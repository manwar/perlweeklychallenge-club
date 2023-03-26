#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @bit_sequences = (
    # Given cases
    [ 1, 0, 0 ],
    [ 1, 1, 1, 0 ],

    # Additional test cases
    [ 1, 0, 1, 1 ],
    [ 1, 0, 1, 1, 0 ],
    [ 1, 0, 1, 1, 0, 0 ],
    [ 1, 0, 1, 1, 0, 1 ]
);

print("\n");
foreach my $bit_sequence (@bit_sequences){
    my $result = convert_bit_sequence(@{$bit_sequence});

    if(defined($result)){
        # Convert to 1 or 0 depending on
        # whether the last char is 'a'
        $result = ($result =~ m/a$/) ? 1 : 0;
    } else{
        $result = "Invalid sequence";
    }

    printf(
        "Input: \@bits = (%s)\nOutput: %s\n\n",
        join(", ", @{$bit_sequence}),
        $result
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Convert a bit sequence into a string of characters that have been encoded
# into said sequence.
# Valid sequences are:
# 0  --> "a"
# 10 --> "b"
# 11 --> "c"
# Takes one argument:
# * A list of bits to convert (e.g. ( 1, 0, 1, 1, 0, 0 ) )
# Returns on success:
# * The decoded string equivalent of the bit list (e.g. "bcaa" )
# Returns on error:
# * undef if an invalid character sequence is detected
################################################################################
sub convert_bit_sequence{

    my $string = "";

    while(scalar(@ARG)){
        if($ARG[0]){
            # 1 initial bit
            shift();
            if($ARG[0]){
                # 1 second bit
                shift();
                $string .= "c";
            } else{
                # 0 second bit, or undef (no
                # second bit)
                if(defined($ARG[0])){
                    # 0 second bit
                    shift();
                    $string .= "b";
                } else{
                    # No second bit
                    return(undef);
                }
            }
        } else{
            # 0 initial bit
            shift();
            $string .= "a";
        }
    }

    return($string);

}



