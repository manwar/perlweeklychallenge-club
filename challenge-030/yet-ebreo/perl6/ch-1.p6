# Write a script to list dates for Sunday 
# Christmas between 2019 and 2100. 
# For example, 25 Dec 2022 is Sunday.

for 2019..2100 -> $year {
    my $date = Date.new($year, 12, 25);
    if ($date.day-of-week == 7) {
        say "12/25/$year"
    }
}

# perl6 .\ch-1.p6
# 12/25/2022
# 12/25/2033
# 12/25/2039
# 12/25/2044
# 12/25/2050
# 12/25/2061
# 12/25/2067
# 12/25/2072
# 12/25/2078
# 12/25/2089
# 12/25/2095