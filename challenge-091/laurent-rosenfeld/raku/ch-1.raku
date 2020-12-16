use v6;

my @tests = <1122234 2333445 12345>;
say $_.fmt("%-10d -> "), count-numbers $_ for @tests;

sub count-numbers (Int $n) {
    my $result = "";
    my @digits = $n.comb;
    my $start = shift @digits;
    my $count = 1;
    for @digits -> $digit {
        if $digit eq $start {
            $count++;
        } else {
            $result ~= $count ~ $start;
            $count = 1;
            $start = $digit;
        }
    }
    $result ~= $count ~ $start;
}
