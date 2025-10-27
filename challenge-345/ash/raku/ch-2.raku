# Task 2 of the Weekly Challenge 345
# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/#TASK2

say process 5, -1, -1; # 5 -1
say process 3, 7, -1, -1, -1; # 7 3 -1
say process 2, -1, 4, -1, -1; # 2 4 2
say process 10, 20, -1, 30, -1, -1; # 20 30 20
say process -1, -1, 5, -1; # -1 -1 5

sub process(*@data) {
    my @seen;
    my @ans;

    my $x = 0;

    for @data -> $val {
        if $val > 0 {
            @seen.unshift($val);
            $x = 0; # this was not clear from the task
        }
        elsif $val == -1 {
            if $x < @seen.elems {
                @ans.push(@seen[$x]);
            }
            else {
                @ans.push(-1);
            }

            $x++;
        }
    }

    return @ans;
}
