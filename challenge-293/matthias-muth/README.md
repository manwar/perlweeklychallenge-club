# Domino Frequencies and the Vectorized Boomerang

**Challenge 293 solutions in Perl by Matthias Muth**



### Summary

**Similar Dominos**:<br/>
Two lines of code to compute frequencies of Domino value combinations
and then to sum them up.

**Boomerang**:<br/>
Thank you for helping me to get a refresher in vector geometry!<br/>
It only needs two formulas and one comparison
for checking whether the input points form a 'boomerang',
using integer arithmetics only (no divisions, no square roots).



## Task 1: Similar Dominos

> You are given a list of dominos, @dominos.<br/>
> Write a script to return the number of dominos that are similar to any other domino.<br/>
> \$dominos[i] = [a, b] and \$dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).<br/>
> <br/>
> Example 1<br/>
> Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])<br/>
> Output: 2<br/>
> Similar Dominos: \$dominos[0], \$dominos[1]<br/>
> <br/>
> Example 2<br/>
> Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])<br/>
> Output: 3<br/>
> Similar Dominos: \$dominos[0], \$dominos[1], \$dominos[3]<br/>

My thinking process:

+ For counting the number of *similar* dominos,
  we can first count for each distinct value combination how often is exists,
  and then sum up the numbers of those that exist more than once. 

+ Counting how often each value combination exists
  is the same as getting their *frequencies*.
  That's something we've done quite often before.<br/>
  In Perl typically a hash is used, with the domino combination as the key,
  and the frequency as the value.
  Today, I will let `List::MoreUtils` do the job
  of creating the frequency hash.<br/>
  Less typing ;-). 
  
+ To use the two numbers on a domino as a key,
  we have to combine them into a string.<br/>
  Let's `join` the two numbers with a separator (like `'-'`) in between them.

+ A combination and its inverse (like `[3, 1]` and `[1, 3]`)
  should be considered as being equal.
  They need to be mapped to the same key.
  To get that, it's easiest to just `sort` the two numbers
  (even if there are only two of them)
  before turning them into a key string.<br/>
  Both dominos `[3, 1]` and `[1, 3]`
  will then be counted using  `"1-3"` as the key.

+ The type of sort (numerical or lexical, ascending or descending)
  does not matter at all,
  it is only important that the result is the same
  if the input is in reversed order.<br/>
  The default lexical sort will therefore do nicely.

+ Once we have the frequencies, we add them up,
  but we exclude those having a frequency of 1.<br/>
  (The  frequencies are in the `values` of the frequency hash).

My solution then is this little program:

```perl
use v5.36;
use List::MoreUtils qw( frequency );
use List::Util qw( sum );

sub similar_dominos( $dominos ) {
    my %frequencies = frequency( map { join "-", sort $_->@* } $dominos->@* );
    return sum( grep $_ > 1, values %frequencies );
}
```

(`use v5.36` is short for getting subroutine signatures and automatic `strict` and `warnings`. )

I love how Perl makes it easy. 



## Task 2: Boomerang

> You are given an array of points, (x, y).<br/>
> Write a script to find out if the given points are a boomerang.<br/>
> A boomerang is a set of three points that are all distinct and not in a straight line.<br/>
> <br/>
> Example 1<br/>
> Input: @points = ( [1, 1], [2, 3], [3,2] )<br/>
> Output: true<br/>
> <br/>
> Example 2<br/>
> Input: @points = ( [1, 1], [2, 2], [3, 3] )<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> Input: @points = ( [1, 1], [1, 2], [2, 3] )<br/>
> Output: true<br/>
> <br/>
> Example 4<br/>
> Input: @points = ( [1, 1], [1, 2], [1, 3] )<br/>
> Output: false<br/>
> <br/>
> Example 5<br/>
> Input: @points = ( [1, 1], [2, 1], [3, 1] )<br/>
> Output: false<br/>
> <br/>
> Example 6<br/>
> Input: @points = ( [0, 0], [2, 3], [4, 5] )<br/>
> Output: true<br/>

We have the three input points<br/>
$` \qquad \qquad p_i = \begin{pmatrix}  x_i \\ y_i \end{pmatrix} |_{  i \in \{ 1 \dots 3 \} } `$

My idea to solve this task is based on the two *vectors* that we get
when we connect these points:<br/>
$` \qquad \qquad
\mathbf{v} = \begin{pmatrix}  x_2 - x_1 \\ y_2 - y_1\end{pmatrix} \qquad
\mathbf{w} = \begin{pmatrix}  x_3 - x_2 \\ y_3 - y_2\end{pmatrix}
`$

For a 'boomerang', we then need to check whether the two vectors have the same direction.

The reason why I'm using this 'vector' approach is
that I hope to avoid any condition checking
that would be necessary for the other possible approach:
comparing the *slope* of the line segments defined by the points.
As the points can have the same $x$-coordinate (like in Example 4),
I would have to deal with possibly infinite slopes (vertical lines).
And in any case, with floating point numbers.
I always try to avoid that if possible.<br/>
Maybe my worries are exaggerated,
but I also found it nice to get a little refresher in vector geometry!

So going with the two vectors:<br/>
I have re-learned (after around 50 years!)
something about the *dot product* (or *scalar product*) of vectors.<br/>
In the [Wikipedia article about the dot product](https://en.wikipedia.org/wiki/Dot_product#Geometric_definition),
it says that if two vectors are *codirectional*,
their dot product is equal to the product of their magnitudes.<br/>
That sounds complicated,
but let's see what that means when we break it down.

The 'dot product' is a scalar number,
and for our two vectors<br/>
$` \qquad \qquad \mathbf{v} = \pmatrix{ x_v \\ y_v } \qquad \mathbf{w} = \pmatrix{ x_w \\ y_w } `$<br/>
it is simply computed like this:<br/>
$` \qquad \qquad \mathbf{v} \cdot \mathbf{w} = x_v x_w + y_v y_w `$.

The 'product of the magnitudes' of the two vectors is<br/>
$` \qquad \qquad \begin{align}
    \| \mathbf{v} \| \, \| \mathbf{w} \|
        &= \sqrt{x_v^2 + y_v^2} \cdot \sqrt{x_w^2 + y_w^2} \\
        &= \sqrt{ (x_v^2 + y_v^2) \: (x_w^2 + y_w^2)}
    \end{align} `$<br/>
The 'magnitude' of a vector is its length,
and you recognize the Pythagorean theorem in the two-dimensional case here.

So for doing the 'boomerang check',
we need to check whether those two are equal:<br/>
$` \qquad \qquad
    x_v x_w + y_v y_w
    = \sqrt{ (x_v^2 + y_v^2) \: (x_w^2 + y_w^2)} `$.

To avoid floating point operations,
and especially something as complicated as computing a square root,
we use a trick and square both sides:

$` \qquad \qquad
    ( x_v x_w + y_v y_w ) ^2
    = (x_v^2 + y_v^2) \: (x_w^2 + y_w^2) `$.

Only integer arithmetics, not even a division in this one!

Squaring both sides also has another positive (pun intended!) effect:<br/>
If the two vectors have the same *direction*,
but a different *orientation*
(one is a *negative* multiple of the other),
their dot product is negative.
Squaring  both sides of the equation eliminates the negative sign,
which is what we actually want.

Now we have something that we can turn into code:

```perl
use v5.36;

sub boomerang( $points ) {
    # Create vectors connecting the points.
    my $v = [ $points->[1][0] - $points->[0][0],
              $points->[1][1] - $points->[0][1] ];
    my $w = [ $points->[2][0] - $points->[1][0],
              $points->[2][1] - $points->[1][1] ];
    
    # Compute the dot product
    # and the *square* of the product of the magnitudes
    # (by not taking the square root).
    my $dot_product = $v->[0] * $w->[0] + $v->[1] * $w->[1];
    my $mag_product_squared =
        ( $v->[0] ** 2 + $v->[1] ** 2 )
            * ( $w->[0] ** 2 + $w->[1] ** 2 );

    # Compare the two.
    return $dot_product ** 2 != $mag_product_squared;
}
```

I added some more tests for corner cases,
like two of the three points being identical, or even all three of them. 

```text
ok 1 - Example 1: boomerang( [[1, 1], [2, 3], [3, 2]] ) is true
ok 2 - Example 2: boomerang( [[1, 1], [2, 2], [3, 3]] ) is false
ok 3 - Example 3: boomerang( [[1, 1], [1, 2], [2, 3]] ) is true
ok 4 - Example 4: boomerang( [[1, 1], [1, 2], [1, 3]] ) is false
ok 5 - Example 5: boomerang( [[1, 1], [2, 1], [3, 1]] ) is false
ok 6 - Example 6: boomerang( [[0, 0], [2, 3], [4, 5]] ) is true
ok 7 - Extra 1: boomerang( [[1, 1], [2, 1], [1, 1]] ) is false (points 1 and 3 identical)
ok 8 - Extra 2: boomerang( [[1, 1], [1, 1], [2, 1]] ) is false (points 1 and 2 identical)
ok 9 - Extra 3: boomerang( [[1, 1], [2, 1], [2, 1]] ) is false (points 2 and 3 identical)
ok 10 - Extra 4: boomerang( [[1, 1], [1, 1], [1, 1]] ) is false (all points identical)
1..10
```

Glad all the tests run successfully!

Maybe next time dealing with vectors, I should try PDL!<br/>
There's always something new to learn!


#### **Thank you for the challenge!**
