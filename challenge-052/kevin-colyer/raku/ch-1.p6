#!perl6
# Task 1 Challenge 052 Solution by kevincolyer
# Stepping Numbers
# Write a script to accept two numbers between 100 and 999. It should 
# then print all Stepping Numbers between them.
# A number is called a stepping number if the adjacent digits have 
# a difference of 1. For example, 456 is a stepping number but 129 
# is not.


# create a list of stepping numbers
# task is not clear if ascending digits only so calculating both
my @steppings = gather for 1..7 -> $a {
    take $a*100+($a+1)*10+($a+2); # ascending difference
    take ($a+2)*100+($a+1)*10+$a; # descending difference
}

sub MAIN(Int $low, $high) {
    die "Low bound [$low] should be >=100 and <= 999" unless $low >= 100 and $low <= 999;
    die "High bound [$high] should be >=100 and <= 999" unless $high >= 100 and $high <= 999;
    
    # filter the steppings number array
    # NB not sure how to chain whateverblock comparisons into one grep, but this is quite clear anyway
    my @s = @steppings.grep( * > $low ).grep( * < $high ).sort;
    
    if @s.elems == 0 {
        say "No stepping numbers between $low and $high"
    } else {
        say "Stepping numbers between $low and $high: [{@s}]"
    }
}

