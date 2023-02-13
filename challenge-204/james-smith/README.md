[< Previous 202](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-202/james-smith) |
[Next 204 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-204/james-smith)

# The Weekly Challenge 203

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-203/james-smith

# Task 1: Special Quadruplets

***You are given an array of integers. Write a script to find out the total special quadruplets for the given array. Special Quadruplets are such that satisfies the following 2 rules. `nums[a] + nums[b] + nums[c] == nums[d]` and `a < b < c < d`.***

## Solution

There isn't much to this one as it is just a case of brute forcing (4 nested loops) which gives us:

```perl
sub special {
  my $c = 0;
  for my $i     (    0 .. $#_-3 ) {
    for my $j   ( $i+1 .. $#_-2 ) {
      my $t = $_[$i]+$_[$j];
      for my $k ( $j+1 .. $#_-1 ) {
        $t+$_[$k]==$_[$_] && $c++ for $k .. $#_;
      }
    }
  }
  $c;
}
```

One slight optimization - we keep a copy of `nums[a]+nums[b]` to skip a sum at the end.

# Task 2: Copy Directory

***You are given path to two folders, `$source` and `$target`. Write a script that recursively copy the directory from `$source` to `$target` except any files.***

## Solution

We look at a non-recursive solution here. We could get `copy_dir` to call iteself - but that means we have a function overhead AND have an overhead of checking conditions we know are true each time we call it.

Instead we use a "queue" to store the directories we wish to check and/or copy. Each time we come across a directory - we create it and then add it to the list of directories to scan..

```perl
sub copy_dir {
  my( $source, $target , @dir_paths )=(@_,'/');
  return unless -d $source && -d $target;
  while( my $path = shift @dir_paths ) {
    opendir my $dh,       $source.$path;
    $_ ne '.' && $_ ne '..'
              && -d       $source.$path.$_
              && mkdir(   $target.$path.$_.'/' )
              && push @dir_paths, $path.$_.'/'
      for readdir $dh;
    closedir $dh;
  }
}
```
