#! /usr/bin/perl6

# Write a script to display months from the year 1900 to 2019 where
# you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

for 1990..2019 -> $y {
  for 1,3,5,7,8,10,12 -> $m {
    if Date.new($y,$m,1).day-of-week == 5 {
      say "$m $y";
    }
  }
}
