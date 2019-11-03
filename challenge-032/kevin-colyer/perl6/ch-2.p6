#!/usr/bin/perl6
use v6;

# 32.ASCII bar chart
#
# Write a function that takes a hashref where the keys are labels and the values are integer or floating point values. Generate a bar graph of the data and display it to stdout.
#
# The input could be something like:
#
# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);
# And would then generate something like this:
#
#  apple | ############
# cherry | ########
# banana | ####
# If you fancy then please try this as well: (a) the function could let you specify whether the chart should be ordered by (1) the labels, or (2) the values.

my %data = ( apple => 3, cherry => 2, banana => 1 );
generate_bar_graph(%data);
generate_bar_graph(%data, :sortByLabel);
generate_bar_graph(%data, :sortDescending);
%data = ( apple => 30, cherry => 25, banana => 3, peach => 40);
generate_bar_graph(%data, :sortDescending, :graphWidth(40));


sub generate_bar_graph(%data, Bool :$sortByLabel=False, Bool :$sortDescending=False, Int :$graphWidth=20) {
    my $lableWidth=[max] %data.keys>>.chars;
    my $max=1+[max] %data.values;
    my $min=[min] %data.values;
    my $multiplier=1/$max*$graphWidth;

    die "not sure I want to display negative values" if $min < 0;

    my @sorted = $sortByLabel==True ?? %data.sort(*.key) !! %data.sort(*.value);
    @sorted.=reverse if $sortDescending;

    for @sorted -> (:$key,:$value) {
        say sprintf("%{$lableWidth}s | ", $key ) ~ "#" x $value*$multiplier;
    };
};
