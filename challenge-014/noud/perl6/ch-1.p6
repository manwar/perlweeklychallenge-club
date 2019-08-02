# Challenge #1

# Write a script to generate Van Eck’s sequence starts with 0. For more
# information, please check out wikipedia page. This challenge was proposed by
# team member Andrezgz.

my @van_eck = 0, {@_.reverse.grep(@_[*-1], :k)[1] || 0} ... *;

# Print the first 100 numbers for the Van Eck series.
say @van_eck[^100];
