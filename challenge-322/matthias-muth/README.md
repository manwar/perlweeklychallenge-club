# Ranking Code, Ranking Numbers

**Challenge 322 solutions in Perl by Matthias Muth**

## Task 1: String Format

> You are given a string and a positive integer.<br/>
> Write a script to format the string, removing any dashes, in groups of size given by the integer. The first group can be smaller than the integer but should have at least one character. Groups should be separated by dashes.
>
> **Example 1**
>
> ```text
> Input: $str = "ABC-D-E-F", $i = 3
> Output: "ABC-DEF"
>```
> 
>**Example 2**
> 
>```text
> Input: $str = "A-BC-D-E", $i = 2
> Output: "A-BC-DE"
> ```
>
> **Example 3**
>
> ```text
>Input: $str = "-A-B-CD-E", $i = 4
> Output: "A-BCDE"
> ```

The first thing to observe is that the `'-'` dash signs in the input strings have absolutely nothing to do with the end result, so we best get rid of them first. Like this:

```perl
    $str =~ s/-//g;
```

Now we have a string that consists of non-dash characters only.<br/>

For putting dashes back in at the right spots, we need to split up that string into chunks of `$i` characters.<br/>
The only chunk that can have less than `$i` characters is at the start of the string.

I tried several approaches:

- Using a regular expression to "chip away" chunks of at most `$i` characters at the end of the string, in a loop.<br/>Then `join` them together with dashes, in reverse order:

  ```perl
      my @chunks;
      while ( $str =~ s/(.{1,$i})$// ) {
          push @chunks, $1;
      }
      return join "-", reverse @chunks;
  ```

  I call this a 'destructive' solution, because the string in `$str` is modified, and completely destroyed in the end.

  I ran a lot of benchmarks for my several solutions (it's so easy with `use Benchmark` and `cmpthese`!).<br/>This solution, on my server, ran a maximum of 18,963 executions/s (using a string of 102 characters) .

- Maybe it's faster when it's 'non-destructive', and using the `/g` global flag instead of a restarting the regular expression in a loop.<br/>
  For working left to right, and still producing the chunks in the same order, I simply reversed the string first. Each chunk will be a reversed string then, and as the chunks have to be reversed anyway, we can just reverse the complete result in the end.<br/>
  Like this:
  
  ```perl
      $str = reverse $str =~ s/-//gr;
      my @chunks;
      push @chunks, $&
          while $str =~ /.{1,$i}/g;
      return scalar reverse join "-", @chunks;
  ```
  
  Ok, quite a bit better: 28,183 executions/s. Roughly 50% more.

* But what if we don't use regular expressions, but just extract the chunks using `substr`?<br/>The first solution using a regex above translates to this, using a `$index` variable as a pointer into the string.

  ```perl
      my ( @chunks, $index );
      for ( $index = length( $str ) - $i; $index >= 0; $index -= $i ) {
          push @chunks, substr $str, $index, $i;
      }
      if ( $index > -$i ) {
          push @chunks, substr $str, 0, length( $str ) % $i;
      }
      return join "-", reverse @chunks;
  ```

  The loop catches *all* chunks of size `$i`. We then need to check whether there is any smaller chunk left at the end, which looks a bit complicated, and clumsy, calculating the number of characters in the last chunk, between `1` and `$i` (inclusively).

  But we are at 102,037 execution/s!

At this point, we can only expect very small benefits when we try to optimize further.<br/>
But maybe we can do some 'cosmetic' changes:

* To avoid that clumsy check at the end, we can make sure that there is at least one character left in the string at the end of the loop. That's easily done by just changing the `$index >= 0` condition to `$index > 0`.  Then we don't need the condition anymore, because we will always have a last chunk outside the loop.

  ```perl
      my ( @chunks, $index );
      for ( $index = length( $str ) - $i; $index > 0; $index -= $i ) {
          push @chunks, substr $str, $index, $i;
      }
      push @chunks, substr( $str, 0, ( length( $str ) - 1 ) % $i + 1 );
      return join "-", reverse @chunks;
  ```

  A minimal gain of speed even: 103,186 executions/s (I ran *a lot* of benchmarks to get reliable maximum numbers).

* Some changes to do 'micro-optimizations'. But actually they reduce the code, too, and can make things more clear:

  * Use a `while` loop instead of the `for` loop. The effect is that the `$index` variable keeps its last value upon exiting the loop, and we can use the last value to determine the size of the last chunk.

  * Having only one statement left inside the loop, we can flip around the loop (syntactically speaking, using a `while`  'statement modifier' instead of a `while` loop).
  
  * Start with the `$index` one chunk size too high, and 'inline' the decrementing (also adapt the end condition).<br/>
    This leaves the size of the last chunk in `$index`, which is very convenient: it eliminates the length calculation.
    
  * We don't need to `push` the last chunk onto the chunk stack, we can use it directly in the return statement. 
  
  ```perl
      my @chunks;
      my $index = length( $str );
      push @chunks, substr $str, $index -= $i, $i
          while $index > $i;
      return join "-", reverse @chunks, substr( $str, 0, $index )
  ```
  

With all of these, we reach an amazing speed of 106,803 executions/s.<br/>
I think it was worth it to go through several iterations of the code.

This is my "best" solution:

```perl
use v5.36;

sub string_format( $str, $i ) {
    $str =~ s/-//g;
    my @chunks;
    my $index = length( $str );
    push @chunks, substr $str, $index -= $i, $i
        while $index > $i;
    return join "-", reverse @chunks, substr( $str, 0, $index );
}
```



## Task 2: Rank Array

> You are given an array of integers.<br/>
> Write a script to return an array of the ranks of each element: the lowest value has rank 1, next lowest rank 2, etc. If two elements are the same then they share the same rank.
>
> **Example 1**
>
> ```text
> Input: @ints = (55, 22, 44, 33)
> Output: (4, 1, 3, 2)
> ```
>
> **Example 2**
>
> ```text
> Input: @ints = (10, 10, 10)
> Output: (1, 1, 1)
> ```
>
> **Example 3**
>
> ```text
> Input: @ints = (5, 1, 1, 4, 3)
> Output: (4, 1, 1, 3, 2)
> ```

In sports events, when two or more participants share the same result, there are different strategies for handling these ties. Most often, the ['1224' standard competition ranking system ](https://en.wikipedia.org/wiki/Ranking#Standard_competition_ranking_(%221224%22_ranking)) is used. If two participants share the same result, their ranking is the same,  and the next rank after them is not assigned.

From the examples I understand that in this task, another ranking system is used: the ['1223', or 'dense' ranking system](https://en.wikipedia.org/wiki/Ranking#Dense_ranking_(%221223%22_ranking)). If there are equal results, they share the same rank, but the next result in the order is assigned the next rank, without gaps.<br/>
This makes the task easier, I think.

After removing all double entries (using `uniq` from `List::Util`), we sort the numbers.<br/>
The index of each element in the sorted array then corresponds to the rank of that element. We just need to add 1 to the index, because the rank is 1-based.

We can build a rank lookup from that, of course using a hash.

The last step is to map every number of the input array to its rank, using that lookup hash.

So this is all:

```perl
use v5.36;
use List::Util qw( uniq );

sub rank_array( @ints ) {
    my @uniq_sorted = sort { $a <=> $b } uniq @ints;
    my %ranks = map { ( $uniq_sorted[$_] => $_ + 1 ) } 0..$#uniq_sorted; 
    return map $ranks{$_}, @ints;
}
```

No fighting for performance this time. ;-)

#### **Thank you for the challenge!**
