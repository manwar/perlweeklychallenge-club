# Write a script to print the smallest pair of Amicable Numbers. For more
# information, please checkout wikipedia page.


sub prop_div(Int $i) {
    return [+] (1..^$i).grep($i %% *);
}

# Anonymous cache handler. Trick copied from fjwhittle (ch-017, ch-1.p6).
&prop_div.wrap: -> $i { .[$i] //= callsame } given Array.new;


# Create a lazy list of all Amicable Numbers.
my @amicables = lazy gather for 1..^Inf -> $m {
    for 1..^$m -> $n {
        take ($n, $m) if prop_div($m) == $n and prop_div($n) == $m;
    }
}


# Print the first three Amicable Numbers.
$_.say for @amicables[^3];
