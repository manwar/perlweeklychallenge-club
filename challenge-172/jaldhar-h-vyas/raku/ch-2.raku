#!/usr/bin/raku

sub MAIN(
    *@args #= a series of numbers
) {
    my @nums = @args.sort;
    my $e = @nums.elems;

    say "minimum:        ", @nums.min;
    say "lower quartile: ", $e %% 2 ?? (@nums[$e / 4 - 1] + @nums[$e / 4]) / 2 !! @nums[$e / 4];
    say "median:         ", $e %% 2 ?? (@nums[$e / 2 - 1] + @nums[$e / 2]) / 2 !! @nums[$e / 2];
    say "upper quartile: ", $e %% 2 ?? (@nums[$e / 4 * 3 - 1] + @nums[$e / 4 * 3]) / 2 !! @nums[$e / 4 * 3];
    say "maximum:        ", @nums.max;
}