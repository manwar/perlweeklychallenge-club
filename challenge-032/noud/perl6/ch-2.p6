# ASCII bar chart
#
# Write a function that takes a hashref where the keys are labels and the
# values are integer or floating point values. Generate a bar graph of the data
# and display it to stdout.
#
# The input could be something like:
#
# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);
#
# And would then generate something like this:
#
#  apple | ############
# cherry | ########
# banana | ####
#
# If you fancy then please try this as well: (a) the function could let you
# specify whether the chart should be ordered by (1) the labels, or (2) the
# values.

sub generate_bar_graph(%data, $sort-on="value") {
    my $vmin = %data.values.min - 1;
    my $vmax = %data.values.max;
    constant $width = 79;

    my @count_array;
    if ($sort-on === "value") {
        @count_array = %data.sort(-*.value)>>.kv;
    } elsif ($sort-on === "key") {
        @count_array = %data.sort(*.key)>>.kv;
    } else {
        die "Unknown sorting argument: $sort-on";
    }

    for @count_array -> ($word, $count) {
        my $times = Int(($count - $vmin) / ($vmax - $vmin) * $width);
        say "$word:\t" ~ "#" x $times;
    }
}

my $data = { 'apple' => 3, 'cherry' => 2, 'banana' => 1 };

say "Sort on value";
generate_bar_graph($data, "value");

say "\nSort on key";
generate_bar_graph($data, "key");
