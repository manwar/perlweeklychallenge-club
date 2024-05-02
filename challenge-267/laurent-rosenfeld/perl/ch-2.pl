use strict;
use warnings;
use feature 'say';

sub line_count {
    my @in_widths = @{$_[0]};
    my $in_str = $_[1];
    my $i = 0;
    my %widths;
    for my $let ('a'..'z') {
        $widths{$let} = $in_widths[$i++];
    }
    my $line_count = 1;
    my $line_width = 0;
    for my $let (split //, $in_str) {
        my $tmp = $line_width + $widths{$let};
        if ($tmp <= 100) {
            $line_width = $tmp;
        } else {
            $line_count++;
            $line_width = $widths{$let};
        }
    }
    return "($line_count, $line_width)";
}

my @tests = ( [[10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                10,10,10,10,10,10,10,10,10,10,10,10],
                "abcdefghijklmnopqrstuvwxyz"],
              [[4,10,10,10,10,10,10,10,10,10,10,10,10,10,
                10,10,10,10,10,10,10,10,10,10,10,10],
                "bbbcccdddaaa"]);

for my $test (@tests) {
    printf "%-28s => ", $test->[1];
    say line_count $test->[0], $test->[1];
}
