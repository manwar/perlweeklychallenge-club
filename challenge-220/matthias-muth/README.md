# This is Perl! We got this, no problem!
**Challenge 219 solutions in Perl by Matthias Muth**

This week's challenges confirm to me why I love Perl:<br/>
Using what the language offers, the idea how to implement it transforms directly into code.<br/>
Evrything works well together, and there is no unnecessary clutter.

## Task 1: Sorted Squares

> You are given a list of numbers.<br/>
> Write a script to square each number in the list and return the sorted list, increasing order.<br/>

This one ends up in a typical Perl one-liner.<br/>
The subroutine's input list of numbers (`@_`) is used to square all its entries using a `map` call
(I used the 'code block' variant here), and the resulting list is sorted,
also using a 'code block' that compares two values numerically to determine their order in the sorted output.<br/>
Perl's `<=>` operator comes in handy to tell whether the fist operand
goes left (`-1`) or right (`+1`) or the two operands are equal (`0`).

More explanation than code! :-)

```perl
sub sorted_squares {
    return sort { $a <=> $b } map { $_ ** 2 }, @_;
}
```

## Task 2: Travel Expenditure

> You are given two list, @costs and @days.<br/>
> The list @costs contains the cost of three different types of travel cards you can buy.<br/>
> For example @costs = (5, 30, 90)<br/>
> Index 0 element represent the cost of  1 day  travel card.<br/>
> Index 1 element represent the cost of  7 days travel card.<br/>
> Index 2 element represent the cost of 30 days travel card.<br/>
> <br/>
> The list @days contains the day number you want to travel in the year.<br/>
> For example: @days = (1, 3, 4, 5, 6)<br/>
> The above example means you want to travel on day 1, day 3, day 4, day 5 and day 6 of the year.<br/>
> <br/>
> Write a script to find the minimum travel cost.<br/>

Let's take the first day that we want to travel.<br/>
On that day, we have three options to take a travel card.
Depending on which option we take, we
* spend some money for buying that card,
* can possibly use that card for some more days on which we want to travel.

After the travel pass period is over, we need to decide again which of the options will be cheaper then
for the rest of the list.

So we are looking at a problem here that should be easy to solve by recursion:
* Apply one of the three options, 
* use the same problem solving routine to determine the 'best' solution for the rest of the input list that is not yet covered.

Do this for all of the options that we have, and then take the best one.

Our recursive subroutine has two parameters:<br/>
a list of costs (which will always have three elements in this challenge),
and a list of days to find the best combination of travel passes for:
```perl
sub travel_expenditure {
    my ( $costs, $days ) = @_;
    ...
}
```
and it will return the minimum cost for travelling on the days given as parameters.

Any function that is being called recursively has to have an end criteria.<br/>
In our case, we return from the subroutine directly if there are no days in the list.
Of course, we then don't need to buy any travel pass at all, and the cost is zero.
```perl
    return 0
        if @$days == 0;
```

For finding the minimum cost for the options we have for the first day,
I could have written out the three cases explicitly, because the challenge description defines
exactly three travel passes.<br/>
This would be easy to read and understand. I hear:  
'Aha! Three very similar lines of code, that clearly corresponds to the three travel passes!'.

Nevertheless I decided to use `map` instead of writing out the three cases explicitly.

This is mainly because I don't like repetitions.<br/>
But then also because by abstracting into a loop, the solution 'scales' better:<br/>
I want to be ready for a 365 day travel pass in the next challenge! :-) 

So we create an array with the durations of the (three ;-)) travel passes,
to use them in whatever loop or `map` we will use:
```perl
my @durations = ( 1, 7, 30 );
```

Then we can 'map' the travel pass numbers (0,1,2) to the respective costs,
determined by the cost for the travel pass itself and the cost for the remaining days that are not covered,
determined by the recursive call. 

For the list of remaining days, we `grep` those days that are later than the current travel pass's duration,
put them into an anonymous array, and use that as the parameter.

Here is the only glitch:<br/>
The `$_` loop variable in the `map` is the number of the travel pass that we currently try.
Within the `grep`, however, `$_` goes through the list of days.
So if we want to use the current travel pass's duration within the `grep`condition,
we can't use `$durations[$_]` there.
We have to store the duration in a `my $duration` variable before,
and use that one within the grep condition.

As the overall
result, we return the minimum of the list of costs returned from the `map` call,
using the `min` function from `List::Util` that we include outside of the function.

So here is the full implementation: 

```perl
use List::Util qw( min );

my @durations = ( 1, 7, 30 );

sub travel_expenditure {
    my ( $costs, $days ) = @_;
    return 0
        if @$days == 0;
    return min(
        map {
            my $duration = $durations[$_];
            $costs->[$_]
                + travel_expenditure( $costs,
                    [ grep $_ >= $days->[0] + $duration, @$days ] );
        } 0..$#{$costs}
    );
}
```

This was fun!

#### **Thank you for the challenge!**
