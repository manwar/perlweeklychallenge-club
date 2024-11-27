#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (qw{ abbc aaabccc abcc });

for my $input (@examples) {
    my $output = string_compression($input);
    say <<"END";
    Input:  \$chars   = "$input"
    Output: "$output"
END
}

sub string_compression ($input) {
    my $output = '';
    while ($input) {
        # get the first character
        my $c = substr( $input, 0, 1 ); 
        # count of identical characters at the start
        # the regex returns a list of what is matched, which 
        # between the lack of the /g flag and the single 
        # parens, gives us one expected result
        # map works on every value in the list, and 
        # ($l) makes $l the first entry of the list.
        my ($l) = map { length } $input =~ /^([$c]+)/mix;
        # ternary operator: If $l is greater than 1, 
        # concatenate the length and the character and 
        # append it to the output, otherwise just append 
        # the character
        $output .= $l > 1 ? $l . $c : $c;
        # remove that first block of characters
        substr( $input, 0, $l ) = '';
    }
    return $output;
}
