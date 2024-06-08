# Semi-Functional Solutions

**Challenge 271 solutions in Perl by Andrew Schneider**

### Intro
This is my first Perl Weekly Challenge. I'm mostly a Python programmer in my day job so I like the chance to develop some other skills. I have a soft spot in my heart for Perl, let's say I'm a Perl slacker. I was surprised how functional this turned out - like functional programming. Also semi-surprised my solution functions. Har har. I have big plans for keeping up with the PWC using a randomly rotating selection of languages each week. I'm working on a script to select the language(s) I'll use -- stay tuned for that.

### What did we learn?
It took me a little while to get the hang of multi-dimensional lists in Perl. Working on it for a little while eventually knocked something loose in the recesses of my brain, and now I feel sufficiently competent handling dimensions up to and including 3. As I said, I'm surprised with how functional these solutions turned out. It *could* be that is just the mindspace I'm in lately (see my Haskell contribution which I wrote after this one), or the problems just seemed suited to this. Anyway, functionally turned out to be a way to do it.

One gotcha I bumped into a few times is the difference between Perl versions. I started using 5.38, then 5.34, then back to 5.38, then 5.34 again, and finally 5.38. Along the way somewhere I picked up subroutine signatures[^1]. After much confusion and cursing I finally realized these weren't added until 5.36, right in the sweet spot between the versions I was trying. The lesson here I suppose is Read the Docs.

Now onto the code.

## Task 1: Maximum Ones

> You are given a m x n binary matrix.<br/>
> <br/>
> Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.<br/>
> <br/>
> Example 1<br/>
> Input: $matrix = [ [0, 1],<br/>
>                    [1, 0],<br/>
>                  ]<br/>
> Output: 1<br/>
> <br/>
> Row 1 and Row 2 have the same number of ones, so return row 1.<br/>
> Example 2<br/>
> Input: $matrix = [ [0, 0, 0],<br/>
>                    [1, 0, 1],<br/>
>                  ]<br/>
> Output: 2<br/>
> <br/>
> Row 2 has the maximum ones, so return row 2.<br/>
> Example 3<br/>
> Input: $matrix = [ [0, 0],<br/>
>                    [1, 1],<br/>
>                    [0, 0],<br/>
>                  ]<br/>
> Output: 2<br/>
> <br/>
> Row 2 have the maximum ones, so return row 2.<br/>

One thing that surprised me here, we want the 1 indexed row. For example, I would have expected the first solution to be 0, the zeroth row. But, I'll solve the problem I'm given.

My solution here is to sum each row of the matrix. I do this using the old map reduce design

```perl
	my @counts = map { reduce {$a + $b} 0, $_->@* } @matrix;
```

Then find the first index of the max value over all the summed rows. I use a loop here for this (would recursion have been a more functional design?). I'm sure there is a better way to do this, but it works, and hey, this is my first PWC.

```perl
    my $idx = 0;
    for (0..scalar(@counts) - 1) {
		if ($counts[$_] > $counts[$idx]) {
			$idx = $_;
		}
    }
```

And that's about it. I return that `$idx` value, then increment it (0 to 1 indexing) outside the function for no particularly good reason.

## Task 2: Sort by 1 bits

> You are give an array of integers, @ints.A<br/>
> <br/>
> Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.<br/>
> <br/>
> Example 1<br/>
> Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)<br/>
> Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)<br/>
> <br/>
> 0 = 0 one bits<br/>
> 1 = 1 one bits<br/>
> 2 = 1 one bits<br/>
> 4 = 1 one bits<br/>
> 8 = 1 one bits<br/>
> 3 = 2 one bits<br/>
> 5 = 2 one bits<br/>
> 6 = 2 one bits<br/>
> 7 = 3 one bits<br/>
> Example 2<br/>
> Input: @ints = (1024, 512, 256, 128, 64)<br/>
> Output: (64, 128, 256, 512, 1024)<br/>
> <br/>
> All integers in the given array have one 1-bits, so just sort them in ascending order.<br/>

At first I thought I was going to end up reusing some pieces of my solution to Task 1 for this, but it turned out to be just different enough that I didn't think it was worth it.

So first we need to convert our integers to some kind of binary representation. In Perl it makes a lot if sense to go to strings, since converting between strings that look like numbers and numbers that look like strings is covered in minute 2 of the 15 Minutes to Perl crash course.

```perl
    my @bins = map { sprintf "%b", $_ } @input;
```

Next we need to sum them up. (Is there a better way to do this? I seem to be repeating this pattern alot.)

```perl
    my @bin_sums = map { reduce { $a + $b } 0, split(//, $_) } @bins;
```

Next I make a list of tuples (pairs) of ( binary sum, integer value ), which I can sort further on. Eep! It's another loop. I'm really harming my functional credentials.

```perl
	my @tuple_list = ();
		for (0..scalar(@bin_sums) - 1) {
			push @tuple_list, ([ $bin_sums[$_], $input[$_]]);
	}
```

Then I sort this super-list, first on the 0th index, then on the 1st

```perl
    my @sorted_list = sort { ${$a}[0] <=> ${$b}[0] || ${$a}[1] <=> ${$b}[1] } @tuple_list;
```

Then map back just to a simple list of integers

```perl
	map { ${$_}[1] } @sorted_list;
```

I think that wraps it up.

## Post script

There wasn't a ton to figure out here, mostly it was an engineering challenge (how do I do *X*?). Plus some self inflicted versioning pain. Really with the amount of functional style stuff going in here, I wonder if I could one-line these. Hmm... Future work I suppose.

Thanks for the challenge!

[^1]: Really? Only just in 5.36?
