# ???

Challenge 242: https://theweeklychallenge.org/blog/perl-weekly-challenge-242/

This week's challenge is pretty fun because it's one of those types of problems that seems really easy but you can end up spending a bunch of time trying to figure out how to solve it in a way that makes some sense.

## Task 1: Missing Members
```
You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

Example 1
Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
Example 2
Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
(1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
```

My command-line knowledge makes me think of just having two files and `diff`'ing them. If I needed to solve this for a real purpose I would probably look to using List::Compare to get it done. But for the challenges I like to think about how else I could go about solving for it.


I call a sub `find_members` passing it the two arrays as references. The sub starts by creating an output string and defaulting it to "Everything matches" in case the two arrays have all the same numbers.

Here's where I got a little silly for fun. I needed to compare array1 to array2 then also compare array2 to array1. A sane person would probably just call a sub twice e.g. `get_diffs(@array1, @array2)` then `get_diffs(@array2, @array1)`. I decided to get "creative."

The sub starts by accepting an array of array refs. I can loop through the array `@_` to run through the process twice (`for (my $i = 0; $i < @arrays; $i++)`). The first time I run it I will be on item 0 so I know I'll be comparing it to item 1: `my $other_arr = 1;` So in the loop, just for clarity I set:
```
my $arr = $arrays[$i];
my $arr_other = $arrays[$other_arr];
```

To find the actual differences between arrays I create a hash mapping the array I'm in to the other array: `my %arr_hash = map {$_=>1} @{$arr_other};` then create an array of differences by `grep`'ing the hash for the values in the current array: `my @diffs = grep { !$arr_hash{$_} } @{$arr};`

This finds the differences but I noticed in the example two output that it should not duplicate the same number multiple times. I think the best way to do that would be with List::MoreUtils but I decided to write out a little loop to create an array of those unique values using a new hash just to keep track:
```
my @unique;
my %seen;
foreach my $value (@diffs) {
    if (! $seen{$value}) {
	push @unique, $value;
	$seen{$value} = 1;
    }
}
```

At this point I want to update the `$output` variable. If there are no differences found it leaves the ouput variable with the default text, otherwise it sets it to the value of the `@unique` differences array. Note that it also checks if the value of `$output` was the default string so it knows if it is setting or appending the new text:

```
# Creating output text if applicable
if ($output eq 'Everything matches') {
    $output = '[' . join(',', @unique) . ']' if @diffs;
}
else {
    $output .= ', [' . join(',', @unique) . ']' if @diffs;	    
}
# now switch to comparing the other direction
$other_arr = 0;
   }
   # Return output to be printed with paranthesis to match task instructions
    return '(' . $output . ')';
}
```

## Task 2: Flip Matrix

```
You are given n x n binary matrix.

Write a script to flip the given matrix as below.

1 1 0
0 1 1
0 0 1

a) Reverse each row

0 1 1
1 1 0
1 0 0

b) Invert each member

1 0 0
0 0 1
0 1 1

Example 1
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
Example 2
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
```

This was a fun task becasuse it's really simple to just look at the examples to know the output (especially with short array lenghts). Reversing numbers and flipping 0's and 1's is easy to do in your head. But how to do it in code? It ends up that it doesn't have to be very tricky either.

I solved this task by passing the matrix array to a sub `matrix_flip` which just uses Perl's native `reverse` to put the array in backwards order then a simple conditional `map` that sets 1's to 0 and 0's to 1. Other than that is just some parentheses and commas for output readability.

```
sub matrix_flip {
    my @matrix_rows = @_;
    my @new_matrix = ();
    
    foreach my $row (@matrix_rows) {
	#the actual flipping - use reverse to swap order and the map to flip values
	my @new_row = '[' . join (", ", reverse map {$_ == 0 ? 1 : 0} @{$row}) . ']';
	push (@new_matrix, @new_row);
    }
    return '(' . join (", ", @new_matrix) . ')';
}
```

The full code with comments is available at https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-242/ianrifkin