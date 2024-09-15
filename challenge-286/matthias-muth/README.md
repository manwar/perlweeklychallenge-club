# The Random Spammer Testing Game

**Challenge 286 solutions in Perl by Matthias Muth**

#### Highlights:

* How to check probabilities of random output using `Test2::V0`.<br/>(Spoiler alert: it's more effort than implementing the solution! But it's worth it!).
* Recent Perl's `builtin 'indexes'` comes in handy for knowing where we are when we walk through an array.

## Task 1: Self Spammer

> Write a program which outputs one word of its own script / source code at random. A word is anything between whitespace, including symbols.<br/>
> <br/>
> Example 1<br/>
> If the source code contains a line such as: 'open my $fh, "<", "ch-1.pl" or die;'<br/>
> then the program would output each of the words { open, my, $fh,, "<",, "ch-1.pl", or, die; }<br/>
> (along with other words in the source) with some positive probability.<br/>
> <br/>
> Example 2<br/>
> Technically 'print(" hello ");' is *not* an example program, because it does not<br/>
> assign positive probability to the other two words in the script.<br/>
> It will never display print(" or ");<br/>
> <br/>
> Example 3<br/>
> An empty script is one trivial solution, and here is another:<br/>
> echo "42" > ch-1.pl && perl -p -e '' ch-1.pl<br/>

#### Implementation

My solution is based on these details:

* The `$0` variable contains the file path of the Perl script that is currently running.
* The common Perl idiom for 'slurping' a file into a single string (localizing the `@ARGV` array and the `$/` 'input record separator' variable in a `do { }` block, setting them to a file name and to `undef`, respectively, and using the magical `<>` 'diamond operator' to return the whole file content):<br/>
        `my $text = do { local ( @ARGV, $/ ) = $file; <> };`
* Using `split` with a string containing a single space character as the first parameter (as opposed to a PATTERN),<br/>
        `split " ", $text;`<br/>
    separates text into chunks using *any amount* of whitespace (not just that single space) as a separator.<br/>
* Using `$array[ rand( @array ) ]` returns a random entry from an array with equal probability.    

Combining all this, my solution subroutine contains only two lines of real code:

```perl
use v5.36;

sub self_spammer() {

    # 'Slurp' the whole source file, and split it into words.
    my @all_words = split " ", do { local ( @ARGV, $/ ) = $0; <> };

    # Return a random word.
    return $all_words[ rand( @all_words ) ];
}
```

#### Testing

Normally, my solution source file contains the subroutine implementing the solution, and one test for each example from the task description, written using `Test2::V0` (which is a core module now! Hooray!).

For this task, the tests have to look differently.<br/>As the subroutine returns a random word from the source file, we cannot just test for a given expected result.<br/>
Instead, we should test that '*the program outputs each of the words in the source with some positive probability*'.

How can we do that?

With a high enough number of calls,
each word of the source file should be returned at least once.
So our testing can be set up like this:

* Determine all the words in the source file, because in the end, we want to see them all.<br/>(This can be implemented very similarly to what is done in the solution procedure, reading the source file and splitting into words, but this time we use `uniq` to get each different word only once.)
  
* Repeatedly call the `self_spammer()` function to get a random word.<br/>Collect them until we have received as many different words
  as we have determined to be contained in the file.
  
* Stop the repetition when we hit a reasonably chosen limit for the number of calls, so that we won't loop forever if anything goes wrong.
  
*  Use a `Test2::V0` comparison function (actually: the very versatile `is`) to compare the list of words that we received
   to the list of words that we know to be in the file. In particular, we do a *set* comparison using a `bag()`  with `item()`s and `end()`.

If this test succeeds, we will have received every different word at least once, which proves that there is a greater-than-zero probability for each word to be returned by our function.

This is the testing section:

```perl
use Test2::V0;
use List::Util qw( uniq );

# Determine all *different* words in the source file
# (very similar to how we did before...).
my @word_list = uniq split " ", do { local ( @ARGV, $/ ) = $0; <> };

# Repeatedly call the solution function to get random words,
# collecting them until we have as many different words as we know are
# contained in the file,
# or until we hit a number of calls limit
# (so that we won't loop forever if anything goes wrong).
my ( $n_calls, $max_n_calls ) = ( 0, 10000 );
my %found;
$found{ self_spammer() } = 1
    until scalar %found == scalar @word_list
        || ++$n_calls >= $max_n_calls;

note "$n_calls calls";
note "found ", scalar %found,
    " of ", scalar @word_list, " different words in file";

is [ keys %found ],
    bag {
        item( $_ )
            for @word_list;
        end();
    },
    "all words were found at least once, and no unexpected words were found";

done_testing;
```

A test run might result in this output (the number of calls will vary from run to run!):

```bash
# 1461 calls
# found 151 of 151 different words in file
ok 1 - all words were found at least once, and no unexpected words were found
1..1
```

As often, here the effort for testing is larger than the effort for the implementation.<br/>
But it feels good to have a well tested challenge solution!



## Task 2: Order Game

> You are given an array of integers, @ints, whose length is a power of 2.<br/>
> Write a script to play the order game (min and max) and return the last element.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)<br/>
> Output: 1<br/>
> Operation 1:<br/>
>     min(2, 1) = 1<br/>
>     max(4, 5) = 5<br/>
>     min(6, 3) = 3<br/>
>     max(0, 2) = 2<br/>
> Operation 2:<br/>
>     min(1, 5) = 1<br/>
>     max(3, 2) = 3<br/>
> Operation 3:<br/>
>     min(1, 3) = 1<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (0, 5, 3, 2)<br/>
> Output: 0<br/>
> Operation 1:<br/>
>     min(0, 5) = 0<br/>
>     max(3, 2) = 3<br/>
> Operation 2:<br/>
>     min(0, 3) = 0<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)<br/>
> Output: 2<br/>
> Operation 1:<br/>
>     min(9, 2) = 2<br/>
>     max(1, 4) = 4<br/>
>     min(5, 6) = 5<br/>
>     max(0, 7) = 7<br/>
>     min(3, 1) = 1<br/>
>     max(3, 5) = 5<br/>
>     min(7, 9) = 7<br/>
>     max(0, 8) = 8<br/>
> Operation 2:<br/>
>     min(2, 4) = 2<br/>
>     max(5, 7) = 7<br/>
>     min(1, 5) = 1<br/>
>     max(7, 8) = 8<br/>
> Operation 3:<br/>
>     min(2, 7) = 2<br/>
>     max(1, 8) = 8<br/>
> Operation 4:<br/>
>     min(2, 8) = 2<br/>

#### Approach

I follow the suggestion given by the example descriptions:

* Walk through the array and take the minimums and the maximums of pairs of numbers.<br/>
  This reduces the array to half its size.
* Execute this operation repeatedly, until there is only one final number left.

#### Implementation

As we walk through pairs of numbers from the array, we need to decide whether we shall take the minimum or the maximum of each pair. If we give each pair an index number, we can use `min()` on pairs with even indexes, and `max()` on pairs with odd indexes.<br/>So let's first split the array into pairs, and enumerate the pairs.

Similar to Python's nice `enumerate()` iterator, Perl now has the `indexed` 'builtin' function, which does something very similar (it has been available since Perl 5.36 as an 'experimental' feature, and 'stable' with Perl 5.40).

So let's first create pairs, using the `pairs` function from `List::Util`, then enumerate them using `indexed`.<br/>For the `@ints` array from Example 1 `( 2, 1, 4, 5, 6, 3, 0, 2 )`,<br/>
    `indexed pairs @ints`<br/>
results in this:<br/>
    `( 0, [ 2, 1 ], 1, [ 4, 5 ], 2, [ 6, 3 ], 3, [ 0, 2 ] )`.

Now lets use `pairs` again:<br/>
    `pairs indexed pairs @ints`<br/>
to get this sequence:<br/>
    `[ 0, [ 2, 1 ] ],`<br/>
    `[ 1, [ 4, 5 ] ],`<br/>
    `[ 2, [ 6, 3 ] ],`<br/>
    `[ 3, [ 0, 2 ] ]`.

With this, it is easy to do the 'min-max-halve-the-array' operation:

```perl
        @ints = map {
            my ( $index, $pair ) = $_->@*;
            $index % 2 == 0
            ? min( $pair->@* )
            : max( $pair->@* );
        } pairs indexed pairs @ints;
```

Repeating it until we have reduced the array to one single element, this is my solution:

```perl
use v5.36;

use List::Util qw( pairs min max );
use builtin 'indexed';
no warnings 'experimental::builtin';

sub order_game( @ints ) {
    while ( @ints > 1 ) {
        @ints = map {
            my ( $index, $pair ) = $_->@*;
            $index % 2 == 0
            ? min( $pair->@* )
            : max( $pair->@* );
        } pairs indexed pairs @ints;
    }
    return $ints[0];
}
```

#### Testing 

The testing section looks a bit simpler here:

```perl
use Test2::V0 qw( -no_srand );
is order_game( 2, 1, 4, 5, 6, 3, 0, 2 ), 1,
    'Example 1: order_game( 2, 1, 4, 5, 6, 3, 0, 2 ) == 1';
is order_game( 0, 5, 3, 2 ), 0,
    'Example 2: order_game( 0, 5, 3, 2 ) == 0';
is order_game( 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ), 2,
    'Example 3: order_game( 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ) == 2';
done_testing;
```

Resulting in this reassuring output:

```text
ok 1 - Example 1: order_game( 2, 1, 4, 5, 6, 3, 0, 2 ) == 1
ok 2 - Example 2: order_game( 0, 5, 3, 2 ) == 0
ok 3 - Example 3: order_game( 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ) == 2
1..3
```



#### **Thank you for the challenge!**
