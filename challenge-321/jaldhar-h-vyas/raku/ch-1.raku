#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @nums = @args.sort({ $^a <=> $^b });
    my %distinct;

    while @nums.elems {
        %distinct{(@nums[0] + @nums[*-1]) / 2}++;
        @nums = @nums[1 .. *-2];
    }

    %distinct.keys.elems.say;
}