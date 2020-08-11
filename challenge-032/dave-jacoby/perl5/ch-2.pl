#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ say state };
use experimental qw{ postderef signatures switch };

# Task #2 - ASCII bar chart

# Write a function that takes a hashref where the keys are labels
# and the values are integer or floating point values. Generate
# a bar graph of the data and display it to stdout.

# The input could be something like:

#   $data = { apple => 3, cherry => 2, banana => 1 };
#   generate_bar_graph($data);

# And would then generate something like this:

#    apple | ############
#   cherry | ########
#   banana | ####

# If you fancy then please try this as well:
#   (a) the function could let you specify whether
#       the chart should be ordered by
#       (1) the labels, or
#       (2) the values.

use List::Util qw{max};
use Getopt::Long;

my $values = 0;
GetOptions( 'values' => \$values, );
my $order = $values ? 'values' : 'label';
my $data = { apple => 3, cherry => 2, banana => 1 };

generate_bar_graph( $data, $order );

exit;

# I am not the happiest with this code, because the length of the
# bar is hardcoded to be 4 times the number given. If data was to show
# the vote tally for even a small local election, the numbers would 
# expand FAR past the size of the terminal. But, given the data we have, 
# it works.

# example used left-padding for the key names, and I replicated that.
# "string x number of repeats" is cool and useful

sub generate_bar_graph ( $data, $order = 'label' ) {
    my @keys = sort keys $data->%*;
    @keys = sort { $data->{$b} <=> $data->{$a} } keys $data->%*
        if $order eq 'values';

    my $max = 4 + max map { length $_ } @keys;

    for my $k (@keys) {
        my $v   = 0 + $data->{$k};
        my $pad = ' ' x ( $max - length $k );
        say join '' , $pad, $k, ' | ',  '#' x ( 4 * $v );
    }
}
