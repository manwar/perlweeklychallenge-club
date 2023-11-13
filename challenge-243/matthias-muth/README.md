# Checking and Flipping

**Challenge 242 solutions in Perl by Matthias Muth**

## Task 1: Missing Members

> You are given two arrays of integers.<br/>
> Write a script to find out the missing members in each other arrays.<br/>
> <br/>
> Example 1<br/>
> Input: @arr1 = (1, 2, 3)<br/>
>        @arr2 = (2, 4, 6)<br/>
> Output: ([1, 3], [4, 6])<br/>
> (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).<br/>
> (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).<br/>
> <br/>
> Example 2<br/>
> Input: @arr1 = (1, 2, 3, 3)<br/>
>        @arr2 = (1, 1, 2, 2)<br/>
> Output: ([3])<br/>
> (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.<br/>
> (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).<br/>

In [perlfaq4](https://perldoc.perl.org/perlfaq4#How-can-I-get-the-unique-keys-from-two-hashes%3F), Brian D Foy gives a recommendation for removing duplicate elements from a list or an array:  

> Use a hash. When you think the words "unique" or "duplicated", think "hash keys".

I would like to extend this good advice to
> Whenever you think "*existence of a value*", think "hash keys"! 

So when we need to decide whether members of one array are contained in the other,
the easiest solution is to first build two hashes from the values of the two arrays.
We create an entry containing the value 1 for each member,
using a common Perl idiom.
As we have two arrays as input to our function,
we use references to the actual arrays as parameters.<br/>
That can look like this:

```perl
    my %arr1_members = map { ( $_ => 1 ) } $arr1->@*;
    my %arr2_members = map { ( $_ => 1 ) } $arr2->@*;
```
Then, we can `grep` through the two arrays, with a condition of the current value *not* existing in the other array's lookup hash.<br/>
There may be duplicate values in the input arrays, but we are supposed to return only distinct values in the results.
So we could  follow the above advice and create another hash to reduce multiple values into distinct ones. But, to make it easy, we can also simply leave that work to the `uniq` function from the `List::Util` core module.<br/>
We then return the results as two anonymous arrays.

Which makes this my complete solution: 

```perl
use List::Util qw( uniq );

sub missing_members( $arr1, $arr2 ) {
    my %arr1_members = map { ( $_ => 1 ) } $arr1->@*;
    my %arr2_members = map { ( $_ => 1 ) } $arr2->@*;
    return (
        [ uniq grep ! $arr2_members{$_}, $arr1->@* ],
        [ uniq grep ! $arr1_members{$_}, $arr2->@* ],
    );
}
```

## Task 2: Flip Matrix

> You are given n x n binary matrix.<br/>
> Write a script to flip the given matrix as below.<br/>
> 1 1 0<br/>
> 0 1 1<br/>
> 0 0 1<br/>
> a) Reverse each row<br/>
> 0 1 1<br/>
> 1 1 0<br/>
> 1 0 0<br/>
> b) Invert each member<br/>
> 1 0 0<br/>
> 0 0 1<br/>
> 0 1 1<br/>
> <br/>
> Example 1<br/>
> Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])<br/>
> Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])<br/>
> <br/>
> Example 2<br/>
> Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])<br/>
> Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])<br/>

We are a bit lucky, because the operations described here can be performed on each row independently, for each row, one by one. This makes things quite easy.<br/>
We can chain the `reverse` operation and the 'inverse' operation
(which is a binary exclusive or, `^`. with the value `1`)
using a `map` call for all values of a row.
The results go into an anonymous array, which will be the resulting row.<br/>
Assuming that the current row is represented by `$_`
containing a reference to the row's data, this does the transformation
for one row:

```perl
    [ map $_ ^ 1, reverse $_->@* ]
```
In Perl's representation of two-dimensional arrays,
each row actually is a reference to an array containing the values of that row.
In addition, in our case, the `$matrix` parameter is a reference itself to the array of row references.<br/>
This means that in an outer `map` call, we can loop over the rows like this:

```perl
    map ..., $matrix->@*;
```
Putting the pieces together, this the complete (one-line :-) ) solution:

```perl
sub flip_matrix( $matrix ) {
    return map [ map $_ ^ 1, reverse $_->@* ], $matrix->@*;
}
```

#### **Thank you for the challenge!**
