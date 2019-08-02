use v6;
sub compare (Int $prev, Int $start) {
    return $prev > $start + 1 ?? "$start-$prev"
        !! $prev > $start     ?? "$start,$prev"
        !! "$prev";
}

my @input = @*ARGS.elems > 0 ?? @*ARGS !! 1,2,3,4,9,10,14,15,16,3,4,5,6,4,5,6,7,9,9;
my $prev_val = my $start_val = shift @input;

my $output = "";
for @input -> $num {
    if ($num != $prev_val + 1) {
        $output ~= compare($prev_val, $start_val) ~ ",";
        $start_val = $num;
    }
    $prev_val = $num;
}
$output ~= compare $prev_val, $start_val;
say $output;
