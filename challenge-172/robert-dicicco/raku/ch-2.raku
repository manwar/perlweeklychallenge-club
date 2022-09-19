use v6;

use Statistics;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-06
# Challenge 172 Five Number Summary ( Raku )

my @arr = (9, 1, 2, 5, 6, 7, 12, 15, 18,19, 27);
#my @arr = (1, 2, 3, 4, 5, 6, 7, 8);
#my @arr = (10,11,12,13,14,15);

my @results  = ();

@results = fivenum(@arr);

print("Unsorted: " ~ @arr ~ "\n");

@arr = sort(@arr);

print("Sorted:   " ~ @arr ~ "\n");

print("Min= @results[0]  Q1= @results[1]  Median= @results[2]  Q3= @results[3]  Max= @results[4]\n");
