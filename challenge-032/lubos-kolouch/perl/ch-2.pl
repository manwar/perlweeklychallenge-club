#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

=head1 NAME

AsciiBarChart - Generate ASCII horizontal bar charts

=head1 SYNOPSIS

    perl ch-2.pl [options]

    Options:
        -sort=labels      Sort by labels (default)
        -sort=values      Sort by values (ascending)
        -sort=values_desc Sort by values (descending)

    Data is provided via STDIN or can be modified in the script.

=head1 DESCRIPTION

Generate ASCII horizontal bar charts from hash/dictionary data.
Keys are labels, values are numeric.

=cut

# Sample data - can be modified or read from input
my $data = {
    apple  => 3,
    cherry => 2,
    banana => 1,
};

# Parse command line options
my $sort_by = 'labels';
if (@ARGV && $ARGV[0] =~ /^-sort=(.+)$/) {
    $sort_by = $1;
    shift @ARGV;
}

# Generate bar chart
generate_bar_chart($data, $sort_by);

sub generate_bar_chart {
    my ($data, $sort_by) = @_;

    # Find maximum label length for alignment
    my $max_length = max(map { length } keys %$data);

    # Find maximum value for scaling
    my $max_value = max(values %$data);

    # Determine sort order
    my @sorted_keys;
    if ($sort_by eq 'values') {
        @sorted_keys = sort { $data->{$a} <=> $data->{$b} } keys %$data;
    } elsif ($sort_by eq 'values_desc') {
        @sorted_keys = sort { $data->{$b} <=> $data->{$a} } keys %$data;
    } else {  # default: sort by labels
        @sorted_keys = sort { $a cmp $b } keys %$data;
    }

    # Generate chart
    for my $key (@sorted_keys) {
        my $bar_length = int(($data->{$key} / $max_value) * 20);  # Scale to 20 chars max
        $bar_length = 1 if $bar_length < 1;  # Minimum 1 hash

        printf "%${max_length}s | %s\n", $key, '#' x $bar_length;
    }
}

=head1 EXAMPLES

    # Default (sorted by labels)
    perl ch-2.pl

    # Sort by values
    perl ch-2.pl -sort=values

    # Sort by values descending
    perl ch-2.pl -sort=values_desc

=cut
