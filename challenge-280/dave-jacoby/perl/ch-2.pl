#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (

    'p|*e*rl|w**e|*ekly|',
    'perl',
    'th|ewe|e**|k|l***ych|alleng|e',

);

for my $input (@examples) {
    my $output = count_asterisks($input);

    say <<"END";
    Input:  \$str = "$input"
    Output: $output
END
}

sub count_asterisks ($str) {
    $str =~ s{
                # if we can comment a regex, we probably should
        \|      # a pipe character
        [^\|]*  # zero or more non-pip characters
        \|      # a pipe character
        }{  }gmix;

    # the = () = forces it into a list context, and otherwise
    # you'd get a boolean result.
    my $c = () = $str =~ /(\*)/gmix;
    return $c;
}

