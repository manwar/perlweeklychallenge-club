Solutions by Walt Mankowski.

# Perl Weekly Challenge #325: Consecutive One and Final Price

I'm home convalescing from some minor surgery, and to pass the time I
thought I'd work on this week's Weekly Challenge for the first time in
ages.

I did the challenge in Perl. I found each challenge pretty easy this
week so I don't have much to say about either of them.

## Task #1: Consecutive One

For this task we're given an array of 0's and 1's and we're asked to
find the maximum number of consecutive 1's.

I didn't use any tricks here, since a single pass through the array is
all that's necessary. If we see a 1 we increase the length of the
current run, and if we see a 0 we reset the run back to 0. That's it.

```perl
sub consecutive_one($ar) {
    my $best = 0;
    my $run = 0;

    for my $d ($ar->@*) {
        if ($d == 1) {
            $run++;
            $best = $run if $run > $best;
        } else {
            $run = 0;
        }
    }

    return $best;
}        
```

## Task #2 Final Price

For this task we given a list of prices and we have to output a new
list with the "final price" of each item in the array. There's a
special sale going on -- if an item with an equal or lower price
occurs later in the list, then the price of the current item is
discounted by the amount of that later item. Only the first such item
is used.

Again, this is simple and doesn't require any special tricks. For each
item in the list, we initialize the discount to 0 and look at all the
following items. If we find one of equal or lesser value, we set the
discount to that value and break out of the loop. At the end of the
loop we subtract the discount (which could still be 0) from the
current item and push it onto the output list.

```perl
sub final_price($ar) {
    my @output;

    for my $i (0..$#$ar) {
        my $discount = 0;
        for my $j ($i+1..$#$ar) {
            if ($ar->[$j] <= $ar->[$i]) {
                $discount = $ar->[$j];
                last;
            }
        }
        push @output, $ar->[$i] - $discount;
    }
    return @output;
}
```
