# Challenge 220 tasks: Perl by Nature - Squareful by Recursion
**Challenge 220 solutions in Perl by Matthias Muth**

## Task 1: Common Characters

> You are given a list of words.<br/>
> Write a script to return the list of common characters (sorted alphabeticall) found in every word of the given list.<br/>

Let's do this step by step.

In the examples, we have a mix of upper and lower case letters in the input words,
but only lower case letters in the output. So first thing, we convert all input words to lowercase:
```perl
sub common_characters {
    my @words = map lc( $_ ), @_;
```

Next, we define a `@results` array that in the end will contain the letters that are contained in all of the input words.
We could start with all letters `"a".."z"`,
and then, going through all words in a loop, filter out all those that are not contained in the respective word.<br/>
But none of the example words has more than five characters,
which means that we will already filter out at least 80 % of the alphabet
when we check against the first word in the list.<br/>
Let's avoid that unnecessary effort, and use the letters from the first input word as our candidates from the beginning.
```perl
    my @letters = split "", $words[0];
```
I'm using `split` here to turn the word into an array of letters.<br/>
Actually I really do love the 'Perl'ish way of using `/./g/` to split `$_` into an array of single characters.
It's shorter to write, and once you know it you know exactly what it is meant to do when you read it. <br/>
But I've run a little benchmark (learning about the `Benchmark` module,
which has been in core literally forever without me knowing that this useful litte tool is available!),
and it seems that actually `split` is faster than `/./g`.<br/>
So `split` it is!

The next step is to filter out those letters that are *not* contained in all words from the list.<br/>
The easiest way to check this is to loop over the words from the list,
reducing our list of characters to only those that are also contained in the respective word.<br/>
Actually we loop over the words starting with the second one, because the first one was used to create the initial
list of letters already:
```perl
    for my $word ( @words[1..$#words] ) {
        @results = grep $word =~ /$_/, @results;
    }
```

And the final step is to return the resulting list, ordered alphabetically (as is the default with `sort`):
```perl
    return sort @results;
}
```
Which makes our little subroutine complete:
```perl
sub common_characters {
    my @words = map lc( $_ ), @_;
    my @letters = split "", $words[0];
    for my $word ( @words[1..$#words] ) {
        @results = grep $word =~ /$_/, @results;
    }
    return sort @results;
}
```


## Task 2: Squareful

> You are given an array of integers, @ints.<br/>
> An array is squareful if the sum of every pair of adjacent elements is a perfect square.<br/>
> Write a script to find all the permutations of the given array that are squareful.<br/>
> Example 1:<br/>
> <br/>
> Input: @ints = (1, 17, 8)<br/>
> Output: (1, 8, 17), (17, 8, 1)<br/>
> <br/>
> (1, 8, 17) since 1 + 8 => 9, a perfect square and also 8 + 17 => 25 is perfect square too.<br/>
> (17, 8, 1) since 17 + 8 => 25, a perfect square and also 8 + 1 => 9 is perfect square too.<br/>
> <br/>
> Example 2:<br/>
> <br/>
> Input: @ints = (2, 2, 2)<br/>
> Output: (2, 2, 2)<br/>
> <br/>
> There is only one permutation possible.<br/>,

There are several tricky things about this one.

First thing, how do we go through the permutations?<br/>
A recursive solution looks very appropriate and applicable to me.<br/>
Which means that within our recursive function we will go through the possible values for the first element in the list,
and then let a recursive call do the job for the rest of the list.

'Tricky' number one:<br/>
Choosing the first value.<br/>
The second example gives an important clue:<br/>
If there are several *same* numbers in the list, we must avoid doing any permutations for them!<br/>
If we numbered the '2's like (2<sub>1</sub>, 2<sub>2</sub>, 2<sub>3</sub>), these would be the permutations:
* (2<sub>1</sub>, 2<sub>2</sub>, 2<sub>3</sub>)
* (2<sub>1</sub>, 2<sub>3</sub>, 2<sub>2</sub>)
* (2<sub>2</sub>, 2<sub>1</sub>, 2<sub>3</sub>)
* (2<sub>2</sub>, 2<sub>3</sub>, 2<sub>1</sub>)
* (2<sub>3</sub>, 2<sub>1</sub>, 2<sub>2</sub>)
* (2<sub>3</sub>, 2<sub>2</sub>, 2<sub>1</sub>)

But they are all the same (2, 2, 2)!<br/>
So even if a number exists more than once in the list, we must only use it once as the 'first element'
before we do the recursion for the rest of the list.

Which means that we must derive a list that contains 'unique' numbers, meaning that each inout number appears only once in that list.
Nothing easier than that in Perl!<br/>
Another look at brian d foy's very nice contribution
_How can I remove duplicate elements from a list or array?_
in the [Perl FAQ](https://perldoc.perl.org/perlfaq4#How-can-I-remove-duplicate-elements-from-a-list-or-array?) helps.
These are his suggestions:
* Use a hash. Like for example:
```perl
my %hash   = map { $_, 1 } @array;
# or a hash slice: @hash{ @array } = ();
# or a foreach: $hash{$_} = 1 foreach ( @array );

my @unique = keys %hash;
```

Ok, let's do it ver similar to that, and there we have a little building block for our recursive function:
```perl
sub squareful {
    my @ints = @_;

    my %unique;
    $unique{$_}++
        for @ints;
```

'Tricky' number two:<br/>
Now that we know which unique numbers to use as the first element of a permutation,
we need to create the list of *remaining* numbers for the recursive call.<br/>
But for me, it would feel like a pain in the neck to have to loop through our list again and again for each number
just to find the number's position in the list, in order to remove it from the list at that position.<br/>
We can do better than that!<br/>
Let's just build an index into our list that has each number's position.
Then it will be easy to derive the list without the current 'first element', by `splice`ing out the element at its position.

One more detail for this:<br/>
It actually will be the *first* position of the number
in case there are several elements of the same number (like in our '2' example above).

We get the first positions of the numbers in the list like this, for example:
```perl
    my %first_positions;
    $first_positions{$ints[$_]} //= $_
        for 0..$#ints;
```

Now let's build our recursive function.

The return value will be the list of all 'squareful' permutations of the input list.<br>
In Perl, we represent this by a list of array references.
That's what we deliver as the final solution, and it will also be what the recursive calls will deliver.

The ending criteria for the recursive calls will be an input list that consists of one element only.
The list of permutations of one element is short. It contains one list which contains the element itself.
So we have another little building block, and the header of our recursive function actually looks like this:
```perl
sub squareful {
    my @ints = @_;

    return [ @ints ]
        if @ints == 1;
```

Then we have the loop that goes through all unique numbers in the list as the first element,
and recursively calls the same function itself to get all 'squareful' permutations of the remaining list of numbers.

For each of those resulting squareful permutations we check
whether it is still suqareful when we combine our first element with the first element of that permutation.
The sum of those two has to be a perfect square. For checking that, we build a little helper function:
```perl
sub is_perfect_square {
    my $sqrt = sqrt( $_[0] );
    return int( $sqrt ) == $sqrt;
}
```

Building it all together, the loop looks like this then:
```perl
    my @results;
    for my $int ( sort keys %unique ) {
        
        my @remaining_ints = @ints;
        splice @remaining_ints, $first_positions{$int}, 1, ();
        
        my @squareful_subsets = squareful( @remaining_ints );
        
        push @results,
            map [ $int, @{$squareful_subsets[$_]} ],
                grep {
                    is_perfect_square( $int + $squareful_subsets[$_][0] );
		} 0..$#squareful_subsets;
    }
    return @results;
}
```

Everything together now:

```perl
sub is_perfect_square {
    my $sqrt = sqrt( $_[0] );
    return int( $sqrt ) == $sqrt;
}

sub squareful {
    my @ints = @_;

    return [ @ints ]
        if @ints == 1;

    my %unique;
    $unique{$_}++
        for @ints;

    my %first_positions;
    $first_positions{$ints[$_]} //= $_
        for 0..$#ints;

    my @results;
    for my $int ( sort keys %unique ) {

        my @remaining_ints = @ints;
        splice @remaining_ints, $first_positions{$int}, 1, ();

        my @squareful_subsets = squareful( @remaining_ints );

        push @results,
            map [ $int, @{$squareful_subsets[$_]} ],
                grep {
                    is_perfect_square( $int + $squareful_subsets[$_][0] );
		} 0..$#squareful_subsets;
    }
    return @results;
}
```

The code in GitHub contains a version that produces readable output for everything it does.
For the first example, the output looks like this:

```
squareful( 1 17 8 )
    frequencies: { 1 => 1, 8 => 1, 17 => 1 }
    first_positions: { 1 => 0, 8 => 2, 17 => 1 }
    trying to start with 1
    remaining_ints: ( 17 8 )
    squareful( 17 8 )
        frequencies: { 8 => 1, 17 => 1 }
        first_positions: { 8 => 1, 17 => 0 }
        trying to start with 17
        remaining_ints: ( 8 )
        squareful( 8 )
            returning ( [ 8 ] )
        squareful_subsets: [8]
        17 + 8 = 25 is a perfect square
        @results now: [17, 8]
        trying to start with 8
        remaining_ints: ( 17 )
        squareful( 17 )
            returning ( [ 17 ] )
        squareful_subsets: [17]
        8 + 17 = 25 is a perfect square
        @results now: ([17, 8], [8, 17])
        returning ([17, 8], [8, 17])
    squareful_subsets: ([17, 8], [8, 17])
    1 + 17 = 18 is no perfect square
    1 + 8 = 9 is a perfect square
    @results now: [1, 8, 17]
    trying to start with 17
    remaining_ints: ( 1 8 )
    squareful( 1 8 )
        frequencies: { 1 => 1, 8 => 1 }
        first_positions: { 1 => 0, 8 => 1 }
        trying to start with 1
        remaining_ints: ( 8 )
        squareful( 8 )
            returning ( [ 8 ] )
        squareful_subsets: [8]
        1 + 8 = 9 is a perfect square
        @results now: [1, 8]
        trying to start with 8
        remaining_ints: ( 1 )
        squareful( 1 )
            returning ( [ 1 ] )
        squareful_subsets: [1]
        8 + 1 = 9 is a perfect square
        @results now: ([1, 8], [8, 1])
        returning ([1, 8], [8, 1])
    squareful_subsets: ([1, 8], [8, 1])
    17 + 1 = 18 is no perfect square
    17 + 8 = 25 is a perfect square
    @results now: ([1, 8, 17], [17, 8, 1])
    trying to start with 8
    remaining_ints: ( 1 17 )
    squareful( 1 17 )
        frequencies: { 1 => 1, 17 => 1 }
        first_positions: { 1 => 0, 17 => 1 }
        trying to start with 1
        remaining_ints: ( 17 )
        squareful( 17 )
            returning ( [ 17 ] )
        squareful_subsets: [17]
        1 + 17 = 18 is no perfect square
        @results now: ()
        trying to start with 17
        remaining_ints: ( 1 )
        squareful( 1 )
            returning ( [ 1 ] )
        squareful_subsets: [1]
        17 + 1 = 18 is no perfect square
        @results now: ()
        returning ()
    squareful_subsets: ()
    @results now: ([1, 8, 17], [17, 8, 1])
    returning ([1, 8, 17], [17, 8, 1])
ok 1 - Example 1: squareful( (1, 17, 8) ) == ([1, 8, 17], [17, 8, 1])
```

That was just a little bit tricky, but the more fun!

#### **Thank you for the challenge!**
