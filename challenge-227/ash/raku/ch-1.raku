# Solution to the Task 1 of the Weekly Challenge 227
# https://theweeklychallenge.org/blog/perl-weekly-challenge-227/#TASK1

# Explanations:
# https://andrewshitov.com/2023/07/24/counting-friday-the-13th-in-raku/

# Test run:
# $ raku ch-1.raku     
# There are 2 Fridays the 13th in 2023:
# 01-13-2023
# 10-13-2023

# $ raku ch-1.raku 2021
# There is only one Friday the 13th in 2021:
# 08-13-2021


my $year = @*ARGS[0] // 2023;

my @dates;
for 1..12 -> $month {
    my $dt = DateTime.new(year => $year, month => $month, day => 13);
    if ($dt.day-of-week == 5) {
        push @dates, $dt;
    }
}

if @dates {
    my $count = @dates.elems;

    if $count == 1 {
        say "There is only one Friday the 13th in $year:";
    }
    else {
        say "There are {@dates.elems} Fridays the 13th in $year:";
    }

    .mm-dd-yyyy.say for @dates;
}
else {
    say "There are no Friday the 13th in $year.";
}
