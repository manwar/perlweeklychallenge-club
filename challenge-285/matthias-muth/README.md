# Connected Coins in an Unconnected World

**Challenge 285 solutions in Perl by Matthias Muth**

## Task 1: No Connection

> You are given a list of routes, @routes.<br/>
> Write a script to find the destination with no further outgoing connection.<br/>
> <br/>
> Example 1<br/>
> Input: @routes = (["B","C"], ["D","B"], ["C","A"])<br/>
> Output: "A"<br/>
> "D" -> "B" -> "C" -> "A".<br/>
> "B" -> "C" -> "A".<br/>
> "C" -> "A".<br/>
> "A".<br/>
> <br/>
> Example 2<br/>
> Input: @routes = (["A","Z"])<br/>
> Output: "Z"<br/>

At first glance, it seems like we need to construct a directed graph, for then analyzing it for finding the end nodes of that graph.

We don't! It's much easier!

If a destination (the right side in a route) has 'no further outgoing connection', this simply means that it does not appear as a source node (on the left side) in any route.

So if we put all routes (source => destination) into a hash, we can use it for an existence check for all destinations.

For constructing that hash from the pairs given in the `$routes` array-ref parameter,
I use the `unpairs` function from `List::Util`. It takes the pairs and flattens them, so that we can directly assign it to a hash variable.

Then, I look up the 'unconnected destination' by searching through the destinations (which happen to be the `values` of our hash) to find the one that has no route entry in the hash. Actually I use `first` (also from `List::Util`) instead of `grep`, just in case the data contain more that one unconnected destinations. 

```perl
use v5.36;
use List::Util qw( unpairs first );

sub no_connection( $routes ) {
    # Store all given routes in a hash ( source => destination ).
    my %connections = unpairs $routes->@*;
    # Return the first destination that does not have a route going out of it.
    return first { ! exists $connections{$_} } values %connections;
}
```

## Task 2: Making Change

> Compute the number of ways to make change for given amount in cents. By using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many distinct ways can the total value equal to the given amount? Order of coin selection does not matter.<br/>
> A penny (P) is equal to 1 cent.<br/>
> A nickel (N) is equal to 5 cents.<br/>
> A dime (D) is equal to 10 cents.<br/>
> A quarter (Q) is equal to 25 cents.<br/>
> A half-dollar (HD) is equal to 50 cents.<br/>
> <br/>
> Example 1<br/>
> Input: \$amount = 9<br/>
> Ouput: 2<br/>
> 1: 9P<br/>
> 2: N + 4P<br/>
> <br/>
> Example 2<br/>
> Input: \$amount = 15<br/>
> Ouput: 6<br/>
> 1: D + 5P<br/>
> 2: D + N<br/>
> 3: 3N<br/>
> 4: 2N + 5P<br/>
> 5: N + 10P<br/>
> 6: 15P<br/>
> <br/>
> Example 3<br/>
> Input: \$amount = 100<br/>
> Ouput: 292<br/>

I use a **recursive approach** for this task.

To get good sequences, without any permutations, all sequences are generated using higher coin values first, with only the same or lower values following. This means that whenever we add a given value to a sequence, we need to make sure that no higher values will be added to it anymore.

How do we do that?

For the parameters of my recursive function, we don't only use the amount to change, but also a list of currently available coins values. This list can (and will!) vary as we descend down into the recursion, as higher values will be excluded.

A call to the function walks through those coin values, for each of them trying to add it to the sequence:

* If this coin value is too high, no combination is possible, so nothing is counted.
* If the coin value matches the amount exactly, we have found a combination, which we count (as 1).
* If the coin value is lower than the amount, we use that coin and descend into a recursion,
to find the number of possible combinations for the rest of the amount.<br/>
For that recursive call, the coin values that we give as parameters
are only the current coin value and all following lower ones.<br/>
The number of combinations returned by the recursive call
is added to the total number of combinations in the current call.

For convenience we allow the function to be called with *only* an amount, and *no* list of coin values.
This is for the main call. In that case, we supply the list of coin values from the task description (50, 25, 10, 5, 1) as a default value.

We will get around 7.500 recursive calls for Example 3.<br/>
Perl emits a warning when it detects a certain number of recursive calls (which is not really high). I think it's safe in our case to suppress this warning.   

```perl
use v5.36;
no warnings 'recursion';

sub making_change( $amount, @coins ) {
    @coins = qw( 50 25 10 5 1 )
        unless @coins;
    my $n = 0;
    for ( 0..$#coins ) {
        $n +=
            $coins[$_] > $amount  ? 0
            : $coins[$_] == $amount ? 1
            : making_change( $amount - $coins[$_], @coins[$_..$#coins] );
    }
    return $n;
}

say making_change( 9 );
say making_change( 15 );
say making_change( 100 );
```

'In reality', I use this for actually running the examples:

```perl
use Test2::V0 qw( -no_srand );
is making_change( 9 ), 2,
    'Example 1: making_change( 9 ) == 2';
is making_change( 15 ), 6,
    'Example 2: making_change( 15 ) == 6';
is making_change( 100 ), 292,
    'Example 3: making_change( 100 ) == 292';
done_testing;
```

 which gives me this nice output:

```
ok 1 - Example 1: making_change( 9 ) == 2
ok 2 - Example 2: making_change( 15 ) == 6
ok 3 - Example 3: making_change( 100 ) == 292
1..3
```

 

## **Thank you for the challenge!**
