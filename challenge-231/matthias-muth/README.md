# Min and Max and Senior
**Challenge 231 solutions in Perl by Matthias Muth**

## Task 1: Min Max

> You are given an array of distinct integers.<br/>
> Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (3, 2, 1, 4)<br/>
> Output: (3, 2)<br/>
> The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.<br/>
> <br/>
> Example 2<br/>
> Input: @ints = (3, 1)<br/>
> Output: -1<br/>
> <br/>
> Example 3<br/>
> Input: @ints = (2, 1, 3)<br/>
> Output: (2)<br/>
> The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.<br/>

There is a straightforward solution to this task,
which actually looks very concise, easy to understand, and 'perlish' to me.<br/>
First, we check whether we have enough numbers so that we can eliminate two of them.
Then we find the minimum and maximum values of the array,
and then we `grep` through the array, skipping over those two values.
And we are done: 
```perl
use List::Util qw( min max );

sub min_max( @ints ) {
    return -1
       unless @ints > 2;
    my ( $min, $max ) = ( min( @ints ), max( @ints ) );
    return grep { $_ != $min && $_ != $max } @ints;
}
```

Some thoughts, though:

* We assume that the numbers really are distinct. It's always better to check.
  But we won't run into big problems if they are not.

* This solution uses the `min` and `max` functions from `List::Util`.
  There is a faster solution for getting both the minimum and the maximum
  of a list at the same time, which is `min_max` from `List::MoreUtils` on CPAN.
  (I learned this thanks to some other discussions about this week's challenges!).
  I think that `List::MoreUtils` should be available in Core,
  but here I am not using it 'for educational purposes',
  to keep it simple.

* If the list of numbers is really, really long (I mean `really` long!),
walking through the array three times -- once for `min`, once for `max,
and once for copying almost the whole array -- might show
some potential for optimization.
Maybe `splice`ing out the two numbers out of the existing array could be faster.
But then we also would need to consider the effort for getting the indices
of the minimum and maximum, without walking through the array again,
maybe even two times. So we would need to write a for loop for getting
the minimum, the maximum, and the indexes of the two.
Maybe then the for loop causes more overhead than what we gain.

So let's keep it that simple!

 
## Task 2: Senior Citizens

> You are given a list of passenger details in the form “9999999999A1122”, where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.<br/>
> Write a script to return the count of all senior citizens (age >= 60).<br/>
> <br/>
> Example 1<br/>
> Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")<br/>
> Ouput: 2<br/>
> The age of the passengers in the given list are 75, 92 and 40.<br/>
> So we have only 2 senior citizens.<br/>
> <br/>
> Example 2<br/>
> Input: @list = ("1313579440F2036","2921522980M5644")<br/>
> Ouput: 0<br/>

This task, too, can be solved with one statement without sacrificing readability
too much. 
We `grep` through the array, chaining a pattern match and the check for the age as the
criteria.
This even has the benefit of checking the input data
and filtering out any 'line noise'.
`grep` then conveniently returns the number of matches if we use it in scalar context,
which we make sure by using `scalar`.

So here we go:
```perl
sub senior_citizens( @list ) {
    return scalar grep {
        /^ \d{10} [MF] (\d{2}) \d{2} $/xi
            && $1 >= 60
    } @list;
}
```

#### **Thank you for the challenge!**
