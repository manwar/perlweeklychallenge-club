[< Previous 192](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-192/james-smith) |
[Next 194 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-194/james-smith)

# The Weekly Challenge 193

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-193/james-smith

# Task 1 - Binary string

***You are given an integer, `$n > 0`. Write a script to find all possible binary numbers of size `$n`.***

## Solution

This weeks task 1 is relatively simple. (1) We need to work out what the minimum and maximum
integers are and then just print them padded to the right length. Thankfully Perl is great
at this as it is integral to it's design.

The largest value is '(2^n)-1' and the template for `sprintf` is '`%0{n}b`'. Which gives us

```perl
sub all_binary {                             ## Make a template so we don't have
  my $t = "%0$_[0]b";                        ## to do interpolation everytime
  map { sprintf $t, $_ } 0 .. (1<<$_[0])-1   ## Need brackets as - is actioned                                         
}                                            ## before <<.
```
# Task 2 - Odd String

***You are given a list of strings of same length, `@s`. Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. `a = 0`, `b = 1`, ... `z = 25`.***

You are given a list of integers greater than or equal to zero, `@list`. Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print `-1`

## Solution

To find the unique string we note:

If word one isn't equivalent to word 2 then the word we are looking for is one of these two (the one which doesn't match the 3rd word)
o/w we are looking for the first word that is not equivalent.

### Try 1 - for every string compute a string signature

```perl
sub sig_str {
  my @Q = map { ord $_ } split //,$_[0];
  join '', map { chr(96 + $Q[$_]-$Q[$_+1]) } 0..$#Q-1
}

sub odd_string_sig {
  my $x = sig_str( $_[0] );
  return $_[ $x eq sig_str( $_[2] ) ] if $x ne sig_str( $_[1] );
  splice@_,0,2;
  $x eq sig_str( $_ ) || return $_ for @_
}
```

### Try 2 - replace signature with an array ref, here we write an sig_check which compares a string against arrayref.

```perl
sub sig {
  my @Q = map { ord $_ } split //,$_[0];
  [ map { $Q[$_]-$Q[$_+1] } 0..$#Q-1 ]
}

sub sig_check {
  my( $sig, $str ) = @_;
  my @Q = map { ord $_ } split //,$str;
  $Q[$_]-$Q[$_+1] == $sig->[$_] || return 0 for 0..$#Q-1;
  return 1
}

sub odd_string_sig_check {
  my $x = sig( $_[0] );
  return $_[ sig_check( $x, $_[2] ) ] if !sig_check( $x, $_[1] );
  splice@_,0,2;
  sig_check( $x, $_ ) || return $_ for @_
}
```

### Try 3... A bit outside in...

We start by working out which are the equivalent words to the first word.

Any word is equivalent if it is in this list... So comparisons are light weight...

```perl
sub odd_string_eqs {
  my @Q = map { ord $_ } split//,$_[0];
  my $l=255;
  $l > $_ && ($l=$_) for @Q;
  my $h=0;
  $h < $_ && ($h=$_) for @Q;
  my %eqs = map {
    my $o = $_;
    join( '', map {chr $_+$o} @Q ) => 1
  } 97-$l .. 122-$h;
  return $_[ exists $eqs{$_[2]} ]
    unless   exists $eqs{$_[1]};
  splice@_,0,2;
  exists $eqs{$_} || return $_ for @_
}
```
The lines prior to the `return` - compute this map.
  
### Performance

How much faster are these... depends on how far along the list you need to go until you find the unique element.
Testing a list of strings with the odd one in a random location - we saw:

| Method                 | Speed up |
|----------------------- |--------: |
| signature              |   x  1.0 |
| signature array        |   x  1.4 |
| Equalivalent strings   |   x  2.5 |

