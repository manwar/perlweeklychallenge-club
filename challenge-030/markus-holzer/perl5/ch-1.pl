use Date::Christmas qw(christmasday);
print join "\n", grep { christmasday($_) eq "Sunday" } 2019 .. 2100;