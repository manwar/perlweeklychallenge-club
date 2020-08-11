# Write a script to calculate the total number of weekdays (Mon-Fri) in each
# month of the year 2019.

my @a = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
for ^365 -> $day {
    my $now = Date.new(2019, 1, 1).later(days => $day);
    if (0 < $now.day-of-week < 6) {
        @a[$now.month - 1]++;
    }
}

for <Jan Feb Mar Apr May Jun
     Jul Aug Sep Oct Nov Dec> Z @a -> ($month, $work-days) {
    say "$month: $work-days days";
}
