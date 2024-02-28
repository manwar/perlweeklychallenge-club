# Solution to the Task 2 of the Weekly Challenge #258
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/#TASK2

# Test run:
# $ raku ch-2.raku 
# 17

my @ints = 2, 5, 9, 11, 3;
my $k = 1; # 17
# my $k = 2; # 11
# my $k = 0; # 2

if $k {
    my @indices = (
            (1..*).grep({
                $_.base(2).comb.grep(/1/).elems == $k
            })
        )[^@ints];
    say [+](@ints[@indices].grep: *.defined);
}
else {
    say @ints[0]; # Otherwise no @indices will be ever filled.
}
