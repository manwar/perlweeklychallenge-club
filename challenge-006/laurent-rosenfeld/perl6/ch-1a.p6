use v6;
my @input = @*ARGS.elems > 0 ?? @*ARGS !! 1,2,3,4,9,10,14,15,16,3,4,5,6,4,5,6,7,9,9;
my $prev = my $start = shift @input;
my @result = gather {
    for @input -> $num {
        if $num != $prev + 1 {
            take $prev > $start + 1 ?? "$start-$prev"
              !! $prev > $start     ?? "$start,$prev"
              !! "$prev";
            $start = $num;
        }
        $prev = $num;
    }
}
say @result.append($prev).join(",");
