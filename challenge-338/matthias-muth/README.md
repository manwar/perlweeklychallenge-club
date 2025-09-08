# Small Numbers, and No Matrix at All

**Challenge 337 solutions in Perl by Matthias Muth**

## Task 1: Smaller Than Current

> You are given an array of numbers, @num1.<br/>
> Write a script to return an array, @num2, where \$num2[i] is the count of all numbers less than or equal to \$num1[i].
>
> **Example 1**
>
> ```text
> Input: @num1 = (6, 5, 4, 8)
> Output: (2, 1, 0, 3)
>
> index 0: numbers <= 6 are 5, 4    => 2
> index 1: numbers <= 5 are 4       => 1
> index 2: numbers <= 4, none       => 0
> index 3: numbers <= 8 are 6, 5, 4 => 3
> ```
>
> **Example 2**
>
> ```text
> Input: @num1 = (7, 7, 7, 7)
> Output: (3, 3, 3, 3)
> ```
>
> **Example 3**
>
> ```text
> Input: @num1 = (5, 4, 3, 2, 1)
> Output: (4, 3, 2, 1, 0)
> ```
>
> **Example 4**
>
> ```text
> Input: @num1 = (-1, 0, 3, -2, 1)
> Output: (1, 2, 4, 0, 3)
> ```
>
> **Example 5**
>
> ```text
> Input: @num1 = (0, 1, 1, 2, 0)
> Output: (1, 3, 3, 4, 1)
> ```

There's no way I'm walking through the entire array for each number
just to check and count all the numbers again and again.<br/>
In other words: I want to do better than $O(n^2)$.

So let's see:

*  I need a count of all numbers that are lower than or equal to my current number.<br/>
    I guess it is best to start with counting how often each number occurs.
    As often, I use the `frequency` function (from `List::MoreUtils`).
    Let me illustrate it with Example 5 from the description:
    
    ```perl
        my @num1 = ( 0, 1, 1, 2, 0 );
    
        # Count how often every @num1 number appears.
        # This also gives us the distint @num1 numbers in the hash keys.
        use List::MoreUtils qw( frequency );
        my %freq = frequency @num1;
        # ( 0 => 2, 1 => 2, 2 => 1 )
        # We have 2 times 0, 2 times 1, and 1 time 2.
    ```
    
* In a subsequent step,
    I will want to build a cumulative sum of the frequencies of the numbers,
    for which the numbers must be ordered from lowest to highest.<br/>
    So let's create an array containing the sorted numbers,
    and each number only once.<br/>
    For getting these 'distinct' numbers,
    I can conveniently use the hash keys from the frequency array.
    They are complete and distinct.

    ```perl
        # Sort the distinct @num1 numbers from lowest to highest.
        my @num1_sorted = sort { $a <=> $b } keys %freq;
        # ( 0, 1, 2 )
    ```

* Next, we build the cumulative sums,
    using the same order as the sorted distinct numbers.

    I use `reductions` (from `List::Util`)  for this.
    The code block for a cumulative sum is simply  `{ $a + $b }`. 
    `$a` transports the current state of the cumulated sum
    from iteration to iteration,
    while `$b` is the respective number frequency to add.
    The function then returns all intermediate (`$a`) values,
    which are the cumulative sums up to (and including) each number.

    As the input list for the `reductions` call,
    I supply the number frequencies,
    sorted by their number (not the frequency).
    A `map` call provides this.

    ```perl
        # Create an array of cumulative sums, summing up the frequencies of the
        # numbers in 'sorted' order (not in @num1 order).
        # The sums include all occurrences of each number itself and all lower
        # numbers.
        my @cumulated_sums = reductions { $a + $b } map $freq{$_}, @num1_sorted; 
        # ( 2, 4, 5 )
        # There are 2 numbers less than or equal to 0 (the two 0s themselves),
        # 4 numbers less than or equal to 1 (the two 0s and the two 1s),
        # and 5 numbers less than or equal to 2 (all 5 numbers) 
    ```
    
* Next, I build a lookup hash,
    to associate the respective cumulative sum with every number:

    ```perl
        # Build a hash to map each (distinct) @num1 number to its cumulated sum.
        # Using the fact that the sorted numbers and the cumulated sums are in
        # the same order.
        my %cumulated_sums_lookup =
            map { $num1_sorted[$_] => $cumulated_sums[$_] } keys @num1_sorted;
    ```

    Note that `keys @num1_sorted` (the `keys` function on an array!)
    is a piece of 'modern perl' that means the same as `0..$#num1_sorted`,
    just a bit less typo-prone.

* In the end, we can return the list of 'looked-up' cumulative sums
    for each `@num1` input number.

    With the update of example outputs on
    [The Weekly Challenge](https://theweeklychallenge.org/blog/perl-weekly-challenge-337/#TASK1)
    page, each number itself must not be included in the output counts.
    This simply means to deduct `1` from the cumulative sum for each number:  

    ```perl
        # Map each @num1 number to its cumulated sum (the 'count of all numbers
        # less than or equal to' result).
        # Correct the sums by -1 to ignore the number itself, as per the updated
        # task examples and clarification by Mohammad Sajid Anwar.
        return map $cumulated_sums_lookup{$_} - 1, @num1;
    ```

This is my complete solution (here without the comments):

```perl
use v5.36;
use List::MoreUtils qw( frequency );
use List::Util qw( reductions );

sub smaller_than_current( @num1 ) {
    my %freq = frequency @num1;
    my @num1_sorted = sort { $a <=> $b } keys %freq;
    my @cumulated_sums = reductions { $a + $b } map $freq{$_}, @num1_sorted;
    my %cumulated_sums_lookup =
        map { $num1_sorted[$_] => $cumulated_sums[$_] } keys @num1_sorted;
    return map $cumulated_sums_lookup{$_} - 1, @num1;
}
```



## Task 2: Odd Matrix

> You are given row and col, also a list of positions in the matrix.<br/>
> Write a script to perform action on each location (0-indexed) as provided in the list and find out the total odd valued cells.<br/>
> For each location (r, c), do both of the following:<br/>
> a) Increment by 1 all the cells on row r.<br/>
> b) Increment by 1 all the cells on column c.
>
> **Example 1**
>
> ```text
> Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
> Output: 6
>
> Initial:
> [ 0 0 0 ]
> [ 0 0 0 ]
>
> Apply [0,1]:
> Increment row 0:
> Before     After
> [ 0 0 0 ]  [ 1 1 1 ]
> [ 0 0 0 ]  [ 0 0 0 ]
> Increment col 1:
> Before     After
> [ 1 1 1 ]  [ 1 2 1 ]
> [ 0 0 0 ]  [ 0 1 0 ]
>
> Apply [1,1]:
> Increment row 1:
> Before     After
> [ 1 2 1 ]  [ 1 2 1 ]
> [ 0 1 0 ]  [ 1 2 1 ]
> Increment col 1:
> Before     After
> [ 1 2 1 ]  [ 1 3 1 ]
> [ 1 2 1 ]  [ 1 3 1 ]
>
> Final:
> [ 1 3 1 ]
> [ 1 3 1 ]
> ```
>
> **Example 2**
>
> ```text
> Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
> Output: 0
>
> Initial:
> [ 0 0 ]
> [ 0 0 ]
>
> Apply [1,1]:
> Increment row 1:
> Before    After
> [ 0 0 ]   [ 0 0 ]
> [ 0 0 ]   [ 1 1 ]
> Increment col 1:
> Before    After
> [ 0 0 ]   [ 0 1 ]
> [ 1 1 ]   [ 1 2 ]
>
> Apply [0,0]:
> Increment row 0:
> Before    After
> [ 0 1 ]   [ 1 2 ]
> [ 1 2 ]   [ 1 2 ]
> Increment col 0:
> Before    After
> [ 1 2 ]   [ 2 2 ]
> [ 1 2 ]   [ 2 2 ]
>
> Final:
> [ 2 2 ]
> [ 2 2 ]
> ```
>
> **Example 3**
>
> ```text
> Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
> Output: 0
>
> Initial:
> [ 0 0 0 ]
> [ 0 0 0 ]
> [ 0 0 0 ]
>
> Apply [0,0]:
> Increment row 0:
> Before     After
> [ 0 0 0 ]  [ 1 1 1 ]
> [ 0 0 0 ]  [ 0 0 0 ]
> [ 0 0 0 ]  [ 0 0 0 ]
> Increment col 0:
> Before     After
> [ 1 1 1 ]  [ 2 1 1 ]
> [ 0 0 0 ]  [ 1 0 0 ]
> [ 0 0 0 ]  [ 1 0 0 ]
>
> Apply [1,2]:
> Increment row 1:
> Before     After
> [ 2 1 1 ]  [ 2 1 1 ]
> [ 1 0 0 ]  [ 2 1 1 ]
> [ 1 0 0 ]  [ 1 0 0 ]
> Increment col 2:
> Before     After
> [ 2 1 1 ]  [ 2 1 2 ]
> [ 2 1 1 ]  [ 2 1 2 ]
> [ 1 0 0 ]  [ 1 0 1 ]
>
> Apply [2,1]:
> Increment row 2:
> Before     After
> [ 2 1 2 ]  [ 2 1 2 ]
> [ 2 1 2 ]  [ 2 1 2 ]
> [ 1 0 1 ]  [ 2 1 2 ]
> Increment col 1:
> Before     After
> [ 2 1 2 ]  [ 2 2 2 ]
> [ 2 1 2 ]  [ 2 2 2 ]
> [ 2 1 2 ]  [ 2 2 2 ]
>
> Final:
> [ 2 2 2 ]
> [ 2 2 2 ]
> [ 2 2 2 ]
> ```
>
> **Example 4**
>
> ```text
> Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
> Output: 2
>
> Initial:
> [ 0 0 0 0 0 ]
>
> Apply [0,2]:
> Increment row 0:
> Before         After
> [ 0 0 0 0 0 ]  [ 1 1 1 1 1 ]
> Increment col 2:
> Before         After
> [ 1 1 1 1 1 ]  [ 1 1 2 1 1 ]
>
> Apply [0,4]:
> Increment row 0:
> Before         After
> [ 1 1 2 1 1 ]  [ 2 2 3 2 2 ]
> Increment col 4:
> Before         After
> [ 2 2 3 2 2 ]  [ 2 2 3 2 3 ]
>
> Final:
> [ 2 2 3 2 3 ]
> ```
>
> **Example 5**
>
> ```text
> Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
> Output: 8
>
> Initial:
> [ 0 0 ]
> [ 0 0 ]
> [ 0 0 ]
> [ 0 0 ]
>
> Apply [1,0]:
> Increment row 1:
> Before     After
> [ 0 0 ]    [ 0 0 ]
> [ 0 0 ]    [ 1 1 ]
> [ 0 0 ]    [ 0 0 ]
> [ 0 0 ]    [ 0 0 ]
> Increment col 0:
> Before     After
> [ 0 0 ]    [ 1 0 ]
> [ 1 1 ]    [ 2 1 ]
> [ 0 0 ]    [ 1 0 ]
> [ 0 0 ]    [ 1 0 ]
>
> Apply [3,1]:
> Increment row 3:
> Before     After
> [ 1 0 ]    [ 1 0 ]
> [ 2 1 ]    [ 2 1 ]
> [ 1 0 ]    [ 1 0 ]
> [ 1 0 ]    [ 2 1 ]
> Increment col 1:
> Before     After
> [ 1 0 ]    [ 1 1 ]
> [ 2 1 ]    [ 2 2 ]
> [ 1 0 ]    [ 1 1 ]
> [ 2 1 ]    [ 2 2 ]
>
> Apply [2,0]:
> Increment row 2:
> Before     After
> [ 1 1 ]    [ 1 1 ]
> [ 2 2 ]    [ 2 2 ]
> [ 1 1 ]    [ 2 2 ]
> [ 2 2 ]    [ 2 2 ]
> Increment col 0:
> Before     After
> [ 1 1 ]    [ 2 1 ]
> [ 2 2 ]    [ 3 2 ]
> [ 2 2 ]    [ 3 2 ]
> [ 2 2 ]    [ 3 2 ]
>
> Apply [0,1]:
> Increment row 0:
> Before     After
> [ 2 1 ]    [ 3 2 ]
> [ 3 2 ]    [ 3 2 ]
> [ 3 2 ]    [ 3 2 ]
> [ 3 2 ]    [ 3 2 ]
> Increment col 1:
> Before     After
> [ 3 2 ]    [ 3 3 ]
> [ 3 2 ]    [ 3 3 ]
> [ 3 2 ]    [ 3 3 ]
> [ 3 2 ]    [ 3 3 ]
>
> Final:
> [ 3 3 ]
> [ 3 3 ]
> [ 3 3 ]
> [ 3 3 ]
> ```

Wow, this is a cool task!<br/>
What looks like an exercise in matrix-building can be simplified enormously:

* Firstly, there is no need to really *count* what is in the cells. A simple *even/odd-indicator* that says whether the cell has been visited an even or odd number of times is enough.

* Secondly, it turns out that whenever a row is touched,
  this affects all columns in that row.
  And vice versa, when a column is flipped, all rows are affected.
  So let's not think 'odd fields', but let's think 'odd rows' and 'odd columns'.

  Let's assume a row is 'odd'
  (its row number was used in an odd number of locations).<br/>
  Then in all columns that are 'odd', those row's fields are 'even',
  and fields in 'even' columns keep their 'odd' value from the row.
  
  Similarly, for 'even' rows,
  all those fields are 'odd' that are in 'odd' columns.
  
  Actually we don't need to know exactly *which* fields are even or odd,
  but it's enough to know *how many rows* are even and odd,
  and *how many columns* are even and odd.
  
  That means we don't even need a matrix at all!
  
* And thirdly, for the result,
  if we have the number of  'odd' rows and of  'odd' columns,
  we can *compute* the number of odd fields
  with a single simple formula:<br/>
  The number of 'odd' rows times the number of 'even' columns,
  plus the number of 'even' rows times the number of 'odd' columns.

This is how that translates to Perl:

* Find out how often each row is mentioned in a location,
  and the same for each column
  (using `frequency` again for counting).

* Count the number of 'odd' rows and 'odd' columns.
  (using a binary 'and' (`$_ & 1`) as a shortcut
  for the arithmetic modulo 2 operation (`$_ % 2 != 0`)).

* Calculate the number of '*even*' rows and columns
  (using the total number of rows and columns that were given).

* Return the result.

Putting it all together:

```perl
use List::MoreUtils qw( frequency );

sub odd_matrix( $row, $col, $locations ) {
    my %row_freq = frequency map $_->[0], $locations->@*;
    my %col_freq = frequency map $_->[1], $locations->@*;
    my $n_odd_rows = scalar grep $_ & 1, values %row_freq;
    my $n_odd_cols = scalar grep $_ & 1, values %col_freq;
    my ( $n_even_rows, $n_even_cols ) =
        ( $row - $n_odd_rows, $col - $n_odd_cols );
    return $n_odd_rows * $n_even_cols + $n_even_rows * $n_odd_cols;
}
```

I like these challenges
where you can save programming and computing energy
by simplifying the task to only what is really needed!

#### **Thank you for the challenge!**
