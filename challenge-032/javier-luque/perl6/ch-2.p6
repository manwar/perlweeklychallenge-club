# Test: perl6 ch2.p6
use v6.d;

sub MAIN () {
    my %data   = 'apple' => 3,  'cherry' => 2, 'banana' => 1;
    my %params = 'order_by' => 'size';
    generate_bar_graph(%data, %params);
}

sub generate_bar_graph (%data, %params) {
    my $sort_func;

    # Sorting function - just 2 for now
    {
        when (%params.{'order_by'} eq 'size') {
            $sort_func = sub { %data.{$^b} <=> %data.{$^a} };
        }

        when (%params.{'order_by'} eq 'name') {
            $sort_func = sub { fc($^a) cmp fc($^b) };
        }
    }

    # Print the chart
    for %data.keys.sort($sort_func) -> $key {
        "%10s | %s \n".printf($key, '#' x (4 * %data.{$key}));
    }
}
