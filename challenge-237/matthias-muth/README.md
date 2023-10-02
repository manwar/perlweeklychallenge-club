# Bills in Loops, and Loops in Arrays

**Challenge 236 solutions in Perl by Matthias Muth**

## Task 1: Exact Change

> You are asked to sell juice each costs \$5. You are given an array of bills. You can only sell ONE juice to each customer but make sure you return exact change back. You only have \$5, \$10 and \$20 notes. You do not have any change in hand at first.<br/>
> Write a script to find out if it is possible to sell to each customers with correct change.<br/>
> <br/> 
> Example 1<br/>
> Input: @bills = (5, 5, 5, 10, 20)<br/>
> Output: true<br/>
> From the first 3 customers, we collect three \$5 bills in order.<br/>
> From the fourth customer, we collect a \$10 bill and give back a \$5.<br/>
> From the fifth customer, we give a \$10 bill and a \$5 bill.<br/>
> Since all customers got correct change, we output true.<br/>
> <br/>
> Example 2<br/>
> Input: @bills = (5, 5, 10, 10, 20)<br/>
> Output: false<br/>
> From the first two customers in order, we collect two \$5 bills.<br/>
> For the next two customers in order, we collect a \$10 bill and give back a \$5 bill.<br/>
> For the last customer, we can not give the change of \$15 back because we only have two \$10 bills.
> Since not every customer received the correct change, the answer is false.<br/>
> <br/>
> Example 3<br/>
> Input: @bills = (5, 5, 5, 20)<br/>
> Output: true<br/>

My solution is based on these ideas:

* We serve the customers with the smallest bills first, in order to get good change for the next ones. 
* We keep track of our cash separately for each value, to make it easier to pay back starting with larger bills, then lower ones.
* Whenever a customer can't be paid back his or her change it's a 'sudden death', we can return 'false' immediately. If we make it through the list, we return 'true'.

And that's basically all.

For sorting the customers, and for checking our cash in the right order, I define a function to sort numerically (as the default for `sort` is string comparison, which makes `"5"` larger than `"10"`):

```perl
sub sort_num( @values ) {
    return sort { $a <=> $b } @values;
}
```

Then this is my solution:

```perl
sub exact_change( @bills ) {

    # Keep a count of the bills we have, separately for each value.
    my %cash = ();

    # Serve all the customers,
    # making sure we accept the lowest bills first, for getting change.
    for ( sort_num @bills ) {

        # Accept  the customer's bill.
        ++$cash{$_};

        # We need to give this change:
        my $change_to_return = $_ - 5;

        # Starting with the highest value available,
        # return bills that are lower than or equal to
        # the change we need to return.
        for ( reverse sort_num keys %cash ) {
            while ( $_ <= $change_to_return && $cash{$_} ) {
                --$cash{$_};
                $change_to_return -= $_;
            }
        }

        # No success if we couldn't return the correct change.
        return 0
            if $change_to_return > 0;
    }
    # Success.
    return 1;
}
```

## Task 2: Array Loops

> You are given an array of unique integers.<br/>
> Write a script to determine how many loops are in the given array.<br/>
> To determine a loop: Start at an index and take the number at array[index] and then proceed to that index and continue this until you end up at the starting index.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)<br/>
> Output: 3<br/>
> To determine the 1st loop, start at index 0, the number at that index is 4, proceed to index 4, the number at that index is 15, proceed to index 15 and so on until you're back at index 0.<br/>
> Loops are as below:<br/>
> [4 15 1 6 13 5 0]<br/>
> [3 8 7 18 9 16 12 17 2]<br/>
> [14 11 19 10]<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)<br/>
> Output: 6<br/>
> Loops are as below:<br/>
> [0]<br/>
> [1]<br/>
> [13 9 14 17 18 15 5 8 2]<br/>
> [7 11 4 6 10 16 3]<br/>
> [12]<br/>
> [19]<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)<br/>
> Output: 1<br/>
> Loop is as below:<br/>
> [9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]<br/>

To detect a loop, we follow the 'path' of numbers, using each number as the next index, until we find the index that we started with.

We use a `@visited` array to mark each number on the path, to avoid running into another loop that we already detected.

For each index that we visit, we check whether the number at that index points does not point outside the array (using `exists`, which is shorter than checking against the array bounds).<br/>
None of the examples has any of these, but it's always better to be on the safe side in case we use other test input.

So we loop through the array, trying every number as a possible first number of a loop if it was not yet visited before, either as a part of another loop or as a part of a non-loop sequence that we already tried.

In this simple version we only count the loops, we don't store them for display.<br/>So that should be all:

```perl
sub array_loops( @ints ) {
    my $n_loops = 0;
    my @visited = ();

    for my $start_index ( 0..$#ints ) {
        next if $visited[$start_index];

        my $i = $ints[$start_index];
        while ( exists( $ints[$i] )
            && ! $visited[$ints[$i]]
            && $i != $start_index )
        {
            $visited[$i] = 1;
            $i = $ints[$i];
        }

        ++$n_loops
            if $i == $start_index;
    }
    return $n_loops;
}
```

#### **Thank you for the challenge!**
