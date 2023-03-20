#!/usr/bin/raku

sub MAIN(
    *@nums
) {
    my $missing;
    my %count;

    for 0 .. @nums.end -> $i {
        %count{@nums[$i]}++;

        if $i > 0 && @nums[$i] - @nums[$i - 1] > 1 {
            $missing = @nums[$i] - 1;
        }
    }

    my $duplicate = %count.keys.grep({ %count{$_} > 1; }).first;

    if $duplicate {
        if !defined $missing && $duplicate == @nums[*-1] {
            $missing = @nums[*-1] + 1;
        }

        say q{(} ~ ($duplicate, $missing).join(q{,}) ~ q{)};
    } else {
        say -1;
    }
}