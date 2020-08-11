# Test: perl6 ch1.p6 example1.txt example2.txt
use v6.d;

sub MAIN (*@filenames) {
    my %counts;

    # Loop through each file
    for @filenames -> $filename {
        my $fh = $filename.IO.open orelse .die;

        # Increment count for each word char
        while (my $char = $fh.getc) {
            %counts{$char.lc}++ if ($char.lc ~~ /\w/);
        }
    }

    # Print each char and count
    for %counts.keys.sort -> $item {
        "%2s %5i\n".printf($item, %counts{$item});
    }
}
