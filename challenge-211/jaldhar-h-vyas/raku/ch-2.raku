#!/usr/bin/raku

sub average(@nums) {
    return @nums.sum / @nums.elems;
}

sub MAIN(
    *@nums
) {
    for @nums.permutations -> $i {
        for 1 ..^ @$i.elems -> $j {
            my @array = $i.Array;
            my @part1 = @array.splice(0, $j);
            my @part2 = @array;

            if average(@part1) == average(@part2) {
                say "true";
                exit;
            }
        }
    }
    say 'false';
}