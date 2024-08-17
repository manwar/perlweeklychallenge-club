# Count the Common Ones and the Strong Pairs

**Challenge 277 solutions by Andrew Schneider**

[PWC 277](https://theweeklychallenge.org/blog/perl-weekly-challenge-277/) - Erlang in the mix

This week again I feel like the first task had a little more challenge to it, by a slight edge.

## Task 1: Complete Day

> Task 1: Count Common</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given two array of strings, @words1 and @words2.</br>
> </br>
> Write a script to return the count of words that appears in both arrays exactly once.</br>
> </br>
> Example 1</br>
> Input: @words1 = ("Perl", "is", "my", "friend")</br>
>        @words2 = ("Perl", "and", "Raku", "are", "friend")</br>
> Output: 2</br>
> </br>
> The words "Perl" and "friend" appear once in each array.</br>
> </br>
> Example 2</br>
> Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")</br>
>        @words2 = ("Python", "is", "top", "in", "guest", "languages")</br>
> Output: 1</br>
> Example 3</br>
> Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")</br>
>        @words2 = ("Crystal", "is", "similar", "to", "Ruby")</br>
> Output: 0</br>

Perhaps the trickiest bit was limiting the words to the ones that only occur once in the same list. That actually suggests an idea that I didn't try: filter each list to words that occur once, then concatenate the lists and filter that to words that occur twice, then count.

One consideration that I pondered for about a minute: what is a word? Is "Perl" the same word as "perl"? Is "Apple" at the start of a sentence the same as "apple" at the end of a sentence? Probably, and it wouldn't have been too hard to handle capitalization variation, but it wasn't in any of the examples and I didn't do it (I went far enough to write a `ToUpper` macro in C for it! but I didn't use it).

### Perl

Perl makes this one pretty easy. First I count the unique words in each list, then for each word in the first list, I filter to those that have count 1 in both lists.

```perl
sub common_count ( $r1, $r2 ){
    no warnings 'uninitialized';

    my @words1 = @$r1; my @words2 = @$r2;
    my %word_hash1; my %word_hash2;
    grep { ++$word_hash1{ $_ } } @words1;
    grep { ++$word_hash2{ $_ } } @words2;

    return scalar grep {
	$word_hash1{ $_ } == 1 and
	    $word_hash2{ $_ } == 1 } keys %word_hash1;
}
```

Lots of use of `grep` here, like a real Perler. The first usage just helps to iterate through the list to get the counts. The last line filters the list where the word (key) has value 1 in both hashes. I needed to `no warnings 'uninitialized';` for the cases where the word (key) doesn't occur in the second list at all.

### C

This one spiraled into something. I'll spare you much of the details, but you can check the code if you are interested. The straightforward implementation using core C stuff would probably be to put a 'count-word' struct into a list or an array for each word, then do linear search every time I needed to find a word, or sort it and do binary search. 

But no, not for me. I had the idea to solve this using a binary tree. Ok, not too bad. But then I thought, well if the input is big enough to have a binary tree show any efficiency savings, we'd probably want to have our operations on the tree nodes *not* be recursive. Ah yes, the old iterative binary tree search. 

I implemented two operations: `find_or_add_node` and `linearize_tree`. The former I was able to basically take a recursive find algorithm and wrap it in an infinite while loop. Pleasantly easy. The latter required unearthing some knowledge I once had, but never completely made sense to me before. What I wanted this function to do was to turn a binary tree into an in-order linked list, reusing the right child pointer as the next pointer. I vaguely remembered an algorithm from school, and I hammered away at it until I recollected or recreated all of the details. It seems to work, I'm like 97.5% sure that it will do what it needs to.

Check out the code to see my binary tree functions.

The task specific code follows, first the forest then the trees

```c
int count_common( char **words1, int n1, char **words2, int n2 ) {
  word_count_node *counts1 = find_or_add_node( NULL, words1[0] );
  counts1->count++;
  word_count_node *node;
  for (int i=1; i < n1; i++) {
    node = find_or_add_node( counts1, words1[i] );
    node->count++;
  }
  counts1 = linearize_tree( counts1 );

  word_count_node *counts2 = find_or_add_node( NULL, words2[0] );
  counts2->count++;
  for (int i=1; i < n2; i++) {
    node = find_or_add_node( counts2, words2[i] );
    node->count++;
  }
  counts2 = linearize_tree( counts2 );

  int count = 0;
  int compval;
  while (1) {
    for (; counts1 && counts1->count != 1; counts1 = counts1->right) {}
    for (; counts2 && counts2->count != 1; counts2 = counts2->right) {}

    if (!(counts1 && counts2))
      return count;

    if ((compval = strcmp(counts1->word, counts2->word))) {
      if (compval < 0) {
	counts1 = counts1->right;
      } else {
	counts2 = counts2->right;
      }
    } else {
      count++;
      counts1 = counts1->right;
      counts2 = counts2->right;
    }
  }
}
```

The function takes two word lists and their lengths. We count the occurrence of each word per list

```c
  word_count_node *counts1 = find_or_add_node( NULL, words1[0] );
  counts1->count++;
  word_count_node *node;
  for (int i=1; i < n1; i++) {
    node = find_or_add_node( counts1, words1[i] );
    node->count++;
  }
  counts1 = linearize_tree( counts1 );
```

Create a new tree with the first word and increment its count. Find or add the rest of the words, incrementing the count for each. Then convert the tree into a sorted list.

After this we have a sorted list with counts representing each input list. Next the idea is to walk through each list until the word count is exactly 1. Then compare the head of each list. If the first head is lower than the second, move to the next element of the first list. If the second head is lower than the first, move to the next element of the second list. And if they are equal, we found a common word! Increment the counter and move to the next element on both lists. If at any time, either list becomes empty, return the counter

```c
int count = 0;
  int compval;
  while (1) {
    for (; counts1 && counts1->count != 1; counts1 = counts1->right) {}
    for (; counts2 && counts2->count != 1; counts2 = counts2->right) {}

    if (!(counts1 && counts2))
      return count;

    if ((compval = strcmp(counts1->word, counts2->word))) {
      if (compval < 0) {
	counts1 = counts1->right;
      } else {
	counts2 = counts2->right;
      }
    } else {
      count++;
      counts1 = counts1->right;
      counts2 = counts2->right;
    }
  }
```

As far as C code goes, I think it's pretty sleek. Once I built all the infrastructure, the solution followed easily.

### Erlang

This is a totally new language to me. It had been on my list of interests for a while, I have a book on my shelf about it. It's like a cross between Prolog and, ... ermm maybe a Lisp or something. The big use case for Erlang is doing distributed programming, servers and clients and that kind of thing. So I wouldn't *really* be doing Erlang if it wasn't distributed or *distributed-lite*

Most of the boilerplate is based on the [tutorial](https://www.erlang.org/doc/system/conc_prog.html). I'll show the logic stuff here

```erlang
count_common_words( [WL1, WL2] ) ->
    T1 = ets:new(t1, []),
    T2 = ets:new(t2, []),
    
    [ ets:update_counter(T1, Elem, {2, 1}, {Elem, 0}) || Elem <- WL1 ],
    [ ets:update_counter(T2, Elem, {2, 1}, {Elem, 0}) || Elem <- WL2 ],

    FilterFunc = fun(X) -> element(2, X) =:= 1 end,
    MapFunc = fun(X) -> element(1, X) end,
    L1 = lists:map( MapFunc, 
		    lists:filter( FilterFunc, ets:tab2list(T1) )),
    L2 = lists:map( MapFunc, 
		    lists:filter( FilterFunc, ets:tab2list(T2) )),

    sets:size( sets:intersection( 
		 [
		  sets:from_list(L1),
		  sets:from_list(L2)
		 ] )
	     ).
```

First we create a counter for each word list. Then we do some list comprehension to get the actual counts. 

```erlang
    T1 = ets:new(t1, []),
    T2 = ets:new(t2, []),
    
    [ ets:update_counter(T1, Elem, {2, 1}, {Elem, 0}) || Elem <- WL1 ],
```

The parameters of the `ets:update_count` function are: counter object, element to operate on, a tuple which took me a bit to understand, and a default value for each element. The tuple `{2, 1}` means to update the counter for `Elem` by taking the 2 index and adding 1. So for instance if we wanted to count by 10s the tuple would be `{2, 10}`

Next we convert each counter to a list, then filter on the elements with count 1

```erlang
    FilterFunc = fun(X) -> element(2, X) =:= 1 end,
    MapFunc = fun(X) -> element(1, X) end,
    L1 = lists:map( MapFunc, 
		    lists:filter( FilterFunc, ets:tab2list(T1) )),
```

Finally we find the size of the intersection of the two lists

```erlang
    sets:size( sets:intersection( 
		 [
		  sets:from_list(L1),
		  sets:from_list(L2)
		 ] )
	     ).
```

Erlang's standard library has enough core functionality for everything I have needed so far. Erlang is cool!

## Task 2: Strong Pair

> Task 2: Strong Pair</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given an array of integers, @ints.</br>
> </br>
> Write a script to return the count of all strong pairs in the given array.</br>
> </br>
> A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y).</br>
> </br>
> Example 1</br>
> Input: @ints = (1, 2, 3, 4, 5)</br>
> Ouput: 4</br>
> </br>
> Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)</br>
> </br>
> Example 2</br>
> Input: @ints = (5, 7, 1, 7)</br>
> Ouput: 1</br>
> </br>
> Strong Pairs: (5, 7)

The solution I came up with here, is to first sort the list. Based on the examples, it looks like we want to eliminate duplicates, so do that. Then for index `i` in the sorted list, for `j` starting from `i+1`, while the value at `j` minus the value at `i` is less than `i`, increment the counter, otherwise we can `break`.

As I write this, I had some soul searching to do thinking about whether I was handling possible negative values correctly, my thinking has been updated, and I'm pretty sure they are handled correctly, subject to revision.

### Perl

For Perl we can find unique values by using `grep` and a counter, then sort the filtered values.

```perl
sub count_strong_pairs ( @ints ){
    my %counts;
    my @arr = sort grep { ++$counts{ $_ } == 1 } @ints;

    my $strong_count = 0;
    for my $i (0..$#arr) {
	for my $j ($i+1..$#arr) {
	    if ( $arr[$j] >= 2 * $arr[$i] ) {
		last;
	    }
	    ++$strong_count;
	}
    }
	       
    return $strong_count;
}
```

### C

In C, first I sort, then step through the sorted array keeping only the unique values, using the same array. The logic of this tripped me up a few times, but I think I finally got it.

```c
int strong_count( int *nums, int len ) {
  if (!len)
    return 0;

  qsort( nums, len, sizeof( int ), cf_func );

  // make unique
  int j = 0;
  for (int i=0; i < len; i++) {
    if (nums[i] != nums[j]) {
	nums[++j] = nums[i];
    }
  }
  j++;

  int count = 0;
  for (int i=0; i < j; i++) {
    for (int k=i+1; k < j && nums[k] < 2 * nums[i]; k++) {
      count++;
    }
  }

  return count;
}
```

### Erlang

In Erlang I put together a pretty typical functional set of functions. Working from the bottom up, make the list unique, sort the list, then run a function on each head and tail of the list where we check for strong pairs between the head and every value in the tail. 

```erlang
find_strong_pairs( Num, NumList ) ->
    StrongCheck = fun( X ) -> X < (2 * Num) end,
    length( lists:filter( StrongCheck, NumList ) ).

recur_strong_pairs( [] ) -> [];
recur_strong_pairs( [N|Rest] ) -> 
    [find_strong_pairs( N, Rest )] ++ recur_strong_pairs( Rest ).

count_strong_pairs( Nums ) ->
    UNums = lists:sort( lists:uniq(Nums) ),
    Counts = recur_strong_pairs(UNums),
    lists:sum( Counts ).
```

I don't actually stop early, it checks all values in the tail even though it could stop when it finds the first that doesn't make a strong pair. But I still sort the list because I assume the second value is greater than the first. I am very lazy! but I am just getting started with Erlang. I'll work harder next time, I promise.

## Conclusion

Well there it is, another PWC in the books. See you next week!
