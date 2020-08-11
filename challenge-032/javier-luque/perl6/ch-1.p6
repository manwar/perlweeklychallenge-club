# Test: cat example.txt | perl6 ch1.p6
use v6.d;
use Getopt::Long;
get-options("csv" => my $use_csv);

sub MAIN () {
    my %counts;

    # Increment the counts hash for each line
    for $*IN.lines() -> $line {
        %counts{$line.chomp}++
    };

    # Print the aggregated line items
    for %counts.keys.sort -> $item {
        if ($use_csv) {
            # Normally i'd use a module like Text::CSV
            say $item ~ ',' ~ %counts{$item};
        } else {
            "%-10s %d\n".printf($item, %counts{$item});
        }
    }
}
