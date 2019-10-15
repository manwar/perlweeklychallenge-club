use v6;
for 2019..2100 -> $year {
    say "Christmas of year $year falls on a Sunday."
        if Date.new($year, 12, 25).day-of-week == 7;
}
