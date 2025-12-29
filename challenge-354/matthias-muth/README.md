# Validate to the Max

**Challenge 353 solutions in Perl by Matthias Muth**

## Task 1: Max Words

> You are given an array of sentences.<br/>
> Write a script to return the maximum number of words that appear in a single sentence.
>
> **Example 1**
>
> ```text
> Input: @sentences = ("Hello world", "This is a test", "Perl is great")
> Output: 4
> ```
>
> **Example 2**
>
> ```text
> Input: @sentences = ("Single")
> Output: 1
> ```
>
> **Example 3**
>
> ```text
> Input: @sentences = ("Short", "This sentence has seven words in total", "A B C", "Just four words here")
> Output: 7
> ```
>
> **Example 4**
>
> ```text
> Input: @sentences = ("One", "Two parts", "Three part phrase", "")
> Output: 3
> ```
>
> **Example 5**
>
> ```text
> Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")
> Output: 10
> ```

For this task, my solution is a non-spectacular one-liner:<br/>I let `map` walk through the sentences, with the idea of transforming each sentence into the number of words it contains, which then can be fed into `max` to return the largest number.

For getting the number of words of a sentence, I use `split` with the special split pattern of `" "`, which splits the string on any sequence of whitespace, also removing leading and trailing whitespace. As I want the number of split elements only, not the list itself, I put the call into a scalar context, which does that job. And as the string to be split is in `$_`, which is the implicit default parameter for `split`, I don't need to add it as a parameter explicitly.

So nice and short:

```perl
use v5.36;
use List::Util qw( max );

sub max_words( @sentences ) {
    return max( map scalar( split " " ), @sentences );
}
```

## Task 2: Validate Coupon

> You are given three arrays, @codes, @names and @status.<br/>
> Write a script to validate codes in the given array.
> 
> ```
>A code is valid when the following conditions are true:
> - codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
>- names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
> - status[i] is true.
>```
> 
>Return an array of booleans indicating validity: output[i] is true if and only if codes[i], names[i] and status[i] are all valid.
>
> **Example 1**
>
> ```text
>Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
>        @names  = ("electronics", "restaurant", "electronics", "pharmacy", "grocery")
>        @status = ("true", "false", "true", "true", "true")
> Output: (true, false, true, false, true)
> ```
> 
> **Example 2**
>
> ```text
>Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
>        @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown")
>        @status = ("true", "true", "false", "true", "true")
> Output: (true, true, false, true, false)
> ```
> 
> **Example 3**
>
> ```text
>Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
>        @names  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery")
>        @status = ("true", "true", "false", "true", "true")
> Output: (true, true, false, true, true)
> ```
> 
> **Example 4**
>
> ```text
>Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
>        @names  = ("electronics", "electronics", "grocery", "grocery")
>        @status = ("true", "true", "true", "true")
> Output: (true, true, true, true)
> ```
> 
> **Example 5**
>
> ```text
>Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
>        @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics")
>        @status = ("true", "true", "true", "true", "false")
> Output: (true, true, true, true, false)
> ```

This task is a bit larger, but actually not more complicated. Yet it gives an opportunity to highlight some Perl constructs that can be helpful sometimes.

#### The Validity Lookup

For deciding whether a coupon is from a valid category, I set up a lookup hash first:

```perl
    my @valid_names = qw( electronics grocery pharmacy restaurant );
    my %name_is_valid = map +( $_ => 1 ), @valid_names;
```

I like the way the `qw( ... )` quote operator for word lists works, because the data can be put in without any further punctuation, which makes it easily readable, and also easy to write most of the times.

Another helpful construct is the `+( ... )` expression. The `+` sign makes it clear to the Perl interpreter that the following parentheses is an expression, not a parameter list for the function or operator that precedes it. This makes things unambiguous, again in a readable way.

If I am given these two options for writing that `map` statement, one that is based on a code block for returning the two-value list, and one that uses the `+( ... )` expression, I prefer the second one for its clarity: 

```perl
    my %name_is_valid = map { ( $_ => 1 ) } @valid_names;		# Option 1
    my %name_is_valid = map +( $_ => 1 ), @valid_names;         # Option 2, I prefer.
```

#### Combining the Data

But the most interesting part in this task is to find a way to combine corresponding values from the three input arrayrefs.

This is Perl, and it's **TIMTOWTDI** time!

These are the different ways that I considered before choosing my favorite one:

1. A `for` loop over the indices:

   ```perl
       my @results;
       for ( keys $codes->@* ) {
           push @results,
               $codes->[$_] =~ /^[a-zA-Z0-9_]+$/
                   && $name_is_valid{ $names->[$_] }
                   && $status->[$_] && $status->[$_] !~ /^false/i
       }
       return @results;
   ```

   I am using the `keys` operator instead of the more traditional `0..$codes->$#*`, because for me, it clearly expresses what I want, without needing to think about and write down two explicit values, where I also always have to consider possible off-by-one errors and do more typing.

   Using a `for` loop makes it necessary to first declare a results array, to which one result value is pushed in each iteration, and which is returned in the end. So while it is the more traditional, it is not the most concise solution.

2. A *multi-value* `for` loop:

    ```perl
        use List::Util qw( mesh );
        my @results;
        for my ( $code, $name, $stat )( mesh $codes, $names, $status ) {
            push @results,
                $code =~ /^[a-zA-Z0-9_]+$/
                    && $name_is_valid{$name}
                    && $stat && $stat !~ /^false/i
        }
        return @results;
    ```

    The call to `mesh` merges the three input arrays into a single long list, where every group of three values is a triplet of (code, name, status). The multi-value `for` loop then assigns each group of three consecutive values to the lexical variables defined in the `for` statement.

    The nice thing about this is that now, these values have a name within the loop body. And as they are simple scalars, no indexing is necessary to access the values. This makes the loop body easier to write and easier to read.

    I would prefer this version of a `for` loop when the individual values are used more often within the loop body, because then, repeated indexing into arrays can be avoided. But this is not the case here, and there is merely one single statement inside the loop. That is why in my opinion, the benefit does not merit the complication of using `mesh` and the multi-value `for` loop here.

3. A `map` call over the indexes:

    ```perl
        return map {
            $codes->[$_] =~ /^[a-zA-Z0-9_]+$/
                && $name_is_valid{ $names->[$_] }
                && $status->[$_] && $status->[$_] !~ /^false/i
        } keys $codes->@*;
    ```

    This is the 'functional' version of the `for` loop in alternative 1. The nice thing is that we don't need a result array, because the `map` results can be used directly as the end result. 

    I use a code block `map { ... }` because I like the visual separation of the mapping expression and the driving list of values.

    This is the most concise solution.

4. A `map` call using triplets of values.

    This alternative uses `zip` to combine the values from the three input arrays into a list of triplets. Each entry in that list is an anonymous array containing the three values pertaining to one coupon. This way, we can loop over the coupons themselves instead of any indexes:  

    ```perl
        use List::Util qw( zip );
        return map {
            $_->[0] =~ /^[a-zA-Z0-9_]+$/
                && $name_is_valid{ $_->[1] }
                && $_->[2] && $_->[2] !~ /^false/i
        } zip $codes, $names, $status;
    ```

    What I like about this version is that the data that are scattered in three different input arrays are combined into entities first (the coupons).

     The downside is that this 'anonymizes' the three values. They can only be referenced by their index (0,1 or 2) into the triplet, and they don't have a name.

    As much as I like the grouping into a data structure, I don't like that additional abstraction level of associating a numeric index (0, 1 or 2 in this case) to what could be referenced by a name ('code', 'name', 'status'). Using numeric indexes to address data within a data structure is very common, but it has a bit of old school feeling for me. The alternative of using a hash for the coupon data structure for a small task like this would seem like too much of a good thing to me.

Of course there are more alternatives, but I think that at this point, I decide that I will be going with number 3.<br/>
More or less traditional, but with a functional touch that makes it concise enough for me.

#### Boolean `false` or `"false"`?

Maybe I should explain this part of the condition:

```perl
    ... && $status->[$_] && $status->[$_] !~ /^false/i
```

What this means is that the condition fails if the status value is a boolean `false` value. But as the examples  use *string* values  `"true"` and `"false"` (which actually both have a boolean value of `true`!), the second part explicitly fails if the string `"false"` is detected. We are safe to do that pattern match, because the second part will only be executed if the first part yields a boolean `true` value, which means that the value is defined, and so we can be sure it has a string representation. 

With this double check, the input parameters can be boolean values `true` or `false` (or whatever is considered true or false in Perl), but also the strings `"true"` and `"false"`, and the result is what is expected.

#### Everything combined

So here is 'my' winner:

```perl
use v5.36;
sub validate_coupon_map_index( $codes, $names, $status ) {
    my @valid_names = qw( electronics grocery pharmacy restaurant );
    my %name_is_valid = map +( $_ => 1 ), @valid_names;
    return map {
        $codes->[$_] =~ /^[a-zA-Z0-9_]+$/
            && $name_is_valid{ $names->[$_] }
            && $status->[$_] && $status->[$_] !~ /^false/i
    } keys $codes->@*;
}
```

#### **Thank you for the challenge!**
