[< Previous 142](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-142/james-smith) |
[Next 144 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-144/james-smith)
# Perl Weekly Challenge #143

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-143/james-smith

# Challenge 1 - Calculator

***You are given a string, `$s`, containing mathematical expression. Write a script to print the result of the mathematical expression. To keep it simple, please only accept `+ - * ()`.***`

## The solution

The simple solution is just to "`eval`" the string, but where is the fun in that... We can either go for a tokenizing parser - where we create an array of elements brackets, symbols, numbers, or we can use regular expressions to reduce the equation.

All students will remember BODMAS - Brackets, order, Division/Multiplication, Addition/Division. (or BIDMAS, PIDMAS, PEMDAS or whatever you used to remember it). So we have to break our prasing down into:

 * Brackets
 * Order    - we don't have this in our equations
 * Division/Multiplication - we only have the latter
 * Addition/Subtraction.

So our logic becomes:

 * **B** - Find brackets without brackets within - for these we evaluate the contents using the same algorithm;
 * **M** - If there are no brackets left - we then looking for multiplications from left to right and evaluate these.
 * **AS** - If there are no brackets or multiplications we look at the addition/subtraction again left to right.
 * This gives the following perl function:

```perl
sub evaluate  {
  my $str = shift;
  1 while $str =~ s/\(\s*([^()]*?)\s*\)/       evaluate($1)             /e;
  1 while $str =~ s/(-?\d+)\s*\*\s*(-?\d+)/    $1 * $2                  /e;
  1 while $str =~ s/(-?\d+)\s*([-+])\s*(-?\d+)/$2 eq '+' ? $1+$3 : $1-$3/e;
  return $str;
}
```

For small strings - this is about the same speed as `eval`, for larger strings not so, but in both cases it is "safer" as string `eval` of "tainted" input is a real security risk.

## As a challenge infix->RPN converter than evaluate

On the Perl Programming Facebook Group - the use or RPN was mentioned - and so the challenge lead to reimplementing this by converting the infix notation to Reverse Polish and then evaluating the RPN stack.

Infix `(a+b)*c+d` would become `a b + c * d +` in Reverse Polish Notation. 

To achieve this we set up a dispatch table - which stores methods for every operator we see in the string...
And then when we see an operator in the stream (either infix or rpn) we use the appropriate function. This simplifies the code considerably...

```perl
my( @s, @o, %f ); ## @s <- stack, @o <- output, %f <- method "dispatch" table

## THe 3 values are:
##  precedence
##  fn to apply when finding operator in infix stream
##  fn to apply when finding operator in RPN stream
 
       ##  Precedence
%f = ( ##     Convertion function Infix -> RPN                                 RPN processing function
  '(' => [ 0, sub{ push @s, '('                                             },                        ],
  ')' => [ 0, sub{ push @o, $_     while ($_=pop@s) ne '('                  },                        ],
  '*' => [ 2, sub{ push @o, pop @s while @s && $f{$s[-1]}[0]>1; push@s, '*' }, sub{ $s[-2] *= pop @s }],
  '+' => [ 1, sub{ push @o, pop @s while @s && $f{$s[-1]}[0];   push@s, '+' }, sub{ $s[-2] += pop @s }],
  '-' => [ 1, sub{ push @o, pop @s while @s && $f{$s[-1]}[0];   push@s, '-' }, sub{ $s[-2] -= pop @s }],
);

## Two loops - first line converts infix to rpn
##             second evaluates the rpn string.
sub evaluate_rpn  {
  @o= @s= (); ## Clear output and stack.
              ## If operator use function in f hash to update output/stack
              ##    othewise it is a number and we push to output.
  ($f{$_}) ? (&{$f{$_}[1]}) : (push@o,$_) for $_[0] =~ m{(-?\d+|[-+*()])}g;
              ## If operator use function in f to update stack
              ##    otherwise we push the value onto the stack
              ## ** we use reverse splice to reverse the string AND clear the stack at the
              ##    same time for the loop to work.
  ($f{$_}) ? (&{$f{$_}[2]}) : (push@s,$_) for @o, reverse splice @s,0;
  $s[0];      ## The result is the remaining value in the stack.
}
```

# Challenge 2 - Stealthy Number

***You are given a positive number, `$n`.  Write a script to find out if the given number is Stealthy Number. A positive integer `N` is stealthy, if there exist positive integers `a`, `b`, `c`, `d` such that `a * b = c * d = N` and `a + b = c + d + 1`.***

## The solution

First we find all the factors of `N` (well the ones for where `N=a*b` and `a<b`)

We then store the sum of the factors in a hash (as the keys), we also store the sum of the factors + 1 in the hash {using `++` so what is stored is the count of these numbers}.

So if we have the condition `a+b == c+d+1` is equivalent to seeing which keys in the hash have a value greater than 1. In which case we have our value. For the problem we don't need this value - just whether there is a value. So our function comes down to this.

```perl
sub stealthy_number {
  my($n,%c) = shift;
  $n%$_||($c{$n/$_+$_ }++,$c{$n/$_+$_+1}++) for 1..sqrt$n;
  (grep { $_ > 1 } values %c) ? 1 : 0;
}
```

## An alternative solution

Having played with the solution above - I realised (it should have been obvious) that the pairs of factors will be consecutive, e.g. 12 has 3 pairs 1,12 2,6, 3,4, and the pair that makes this a stealthy number is going to be `2+6 = 3+4+1`.

We can therefore we don't need to keep an array of valid factors - only the previous factor. The code thus becomes:

```perl
sub stealthy_number_1pass {
  my($p,$n) = (1,@_);
  $n%$_?1:$n/$p+$p-$n/$_-$_-1?($p=$_):(return 1)for 2..sqrt$n;
  0;
}
```

OK - that's a bit golfed. So lets unravel the ternaries in the middle to make the code more readable.

```perl
sub stealthy_number_1pass {
  my $n = shift;
  my $p = 1;
  foreach ( 2 .. sqrt $n ) {
    next     if $n % $_;
    return 1 if $n/$p + $p == $n/$_ + $_ + 1;
    $p = $_;
  }
  return 0;
}
```
