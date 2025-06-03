# Task 2 of Week 324
# The Weekly Challenge
# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/#TASK2

say total-xor(1, 3); # 6
say total-xor(5, 1, 6); # 28
say total-xor(3, 4, 5, 6, 7, 8); # 480

sub total-xor(*@data) {
    my $sum = 0;

    for 1..@data.elems {
        for @data.combinations($_) -> @row {            
            $sum += [+^] @row;
        }
    }

    return $sum;
}
