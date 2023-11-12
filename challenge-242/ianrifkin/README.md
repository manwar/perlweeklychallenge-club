# I'm a Map

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

When I first started writing code I tried to:
1) create an hash for each array
2) create an array using the hash to grep values in the other array
3) process the output array to de-duplicate
4) parse the de-duped output array for pretty printing

It worked but it felt messy. Taking a step back to refactor I realized that I could create an array of hashes for the output, very succicintly:

```
my @result_hashes = (
    {map { $_ => check_if_exists($_, $arr2) } @{$arr1}},
    {map { $_ => check_if_exists($_, $arr1) } @{$arr2}}
    );
```

This sets each hash's key to the the value from the array. Then `check_if_exists` just `grep`s the other array for the value and returns true or false:
```
sub check_if_exists {
    my ($k, $arr) = @_;
    return 1 if grep /$k/, @{$arr};
    return 0;
}
```


That's it! Since the `@result_hashes` array contains hashes it is de-duped by naturely. The only remaining step is printing. Interestingly I expended more lines of code to get the printing in the desired format.

Parse hashed results into an @output array where the output array will end up having two values (one for each input).

I loop through the array of hashed results putting the key from the hash in an array if the hash key's value is false (meaning the number was not found in the other array):
```
foreach (@result_hashes) {
	my %h = %{$_};
	my @tmp_out = ();

	foreach my $key ( keys %h ) { 
	    push(@tmp_out, $key) unless $h{$key};
	}
```
Then I put that output into the @output array. Note that that point of having the @tmp_out step is solely to have separation between the two inputs. e.g. I want the output from example 1 to be `(['3','1'],['4','6'])` and not `('3','1','4','6')`:
```
push(@output, \@tmp_out) if @tmp_out;
```

For the final step (and not to make this any longer) I used `Data::Dumper` to return the `@output` array in the desired format:
```
$Data::Dumper::Terse = 1; #don't print VAR names
$Data::Dumper::Indent = 0; #keep output on one line
return '(' . join(',', Dumper(@output)) . ')';
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