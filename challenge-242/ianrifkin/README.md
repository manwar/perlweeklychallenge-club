# Math is hard?

Challenge 241: https://theweeklychallenge.org/blog/perl-weekly-challenge-241/

Some of The Weekly Challenges are more intimidating for me based on how math-heavy the task feels. The first task seemed overwhelming but was pretty quick to create a solution, yet the second task took me much longer.

## Task 1: Arithmetic Triplets

```
You are given an array (3 or more members) of integers in increasing order and a positive integer.

Write a script to find out the number of unique Arithmetic Triplets satisfying the following rules:

a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff
Example 1
Input: @nums = (0, 1, 4, 6, 7, 10)
       $diff = 3
Output: 2

Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.
Example 2
Input: @nums = (4, 5, 6, 7, 8, 9)
       $diff = 2
Output: 2

(0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
(1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.
```

A quick read of this task was overwhelming to me because it sounded like it was going to be more math than I could handle, but upon closer inspection the answer is in the description.

I kept it simple and just explicitely created the three loops with the three specified iterators. It's very helpful to match the incrementor names in my code with the task's description.

I started by looping through the input array with an incrementer `$i`. We know that `$i` is needed for the first value so the max `$i` is going to be 2 less than the total array length: `for (my $i = 0; $i < $nums_length - 2; $i++)`

Within this loop I just make the next loop with `$j` which is 1 more than `$i` to 1 less than the array length: `for (my $j = $i + 1; $j < $nums_length - 1; $j++)`

Finally within that loop I create the loop with `$k` which is going to be 1 more than `$j` to the end of the array: `for (my $k = $j + 1; $k < $nums_length; $k++)`

Now that I have my loops I go back to the instructions which stated:
```
nums[j] - nums[i] == diff
and
nums[k] - nums[j] == diff
```

which in my Perl code is literally that same thing: `$nums[$j] - $nums[$i] == $diff && $nums[$k] - $nums[$j] == $diff`

Anytime the above is true it increments a counter `$total_finds`. After the loops are complete it prints the `$total_finds` counter.

The complete `sub find_triplets` is as follows:

```
sub find_triplets {
    my ($diff, $nums) = @_;
    my $nums_length = scalar @{$nums};
    my $total_finds = 0;
    for (my $i = 0; $i < $nums_length - 2; $i++) {    
	for (my $j = $i + 1; $j < $nums_length - 1; $j++) {
	    for (my $k = $j + 1; $k < $nums_length; $k++) {
		if (@{$nums}[$j] - @{$nums}[$i] eq $diff && @{$nums}[$k] - @{$nums}[$j] eq $diff) {
		    $total_finds++;
		}
	    }
	}
    }
    print "$total_finds\n";
}
```

Full script with comments available at https://github.com/ianrifkin/perlweeklychallenge-club/blob/ianrifkin-challenge-241/challenge-241/ianrifkin/perl/ch-1.pl


## Task 2: Prime Order
```
You are given an array of unique positive integers greater than 2.

Write a script to sort them in ascending order of the count of their prime factors, tie-breaking by ascending value.

Example 1
Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))

Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3
```

This one sounded simple enough but I needed to write WAY more code to accomplish. Though to be fair, part of the length is a lot more code comments and documentation -- critial because this quickly got confusing for me! After I completed it and it was working, I wasn't happy with how long the code got and how I was handling the looping so I refactored it a bit. The main different is the first attempt I really started by trying to find the prime factors and then counting them up. This was useful because it allowed me to check as I went along to make sure I was counting the right things appropriately. But once I got a good sense of it I realized it could be done quicker -- though mostly it's to reduce what felt like messy extra loops in code.

I split up the work into 2 subroutines.


The main sub, `prime_order()`, accepts an array of integers. It loops through the array to create a hash where the key is the input number from the array and the value is number of prime factors for that number. It generates the count of prime factors by calling a sub `prime_finder()`.

```prime_finder```

After the loop is complete `prime_order()` will create and print a sorted array based on the hash results.
```
    foreach my $ordered_num (sort { $results{$a} <=> $results{$b} or $a <=> $b } keys %results) {
	push(@sorted_output, $ordered_num);
    }

    # Finally, print the sorted output
    say "(" . join(", ", @sorted_output) . ")";
```

The sub `prime_finder()` is what actually cacluates the number of prime factors for a given input number.


I start by having a while loop set to repeat endlessly with a manual condition flag. This will be important based on my approach.

Within the while loop I have a for loop that will find the biggest prime factor for a given number. The loop starts at the square root of the number `$i = int(sqrt($num))` and checks if a prime is found by seeing if dividing the number by the iterator has a remainder: `if ($num % $i == 0)`

Some examples:

input is 11 --> int of square root is 3 --> first prime factor found is 1 (meaning 11 is a prime number). In this case it increments the counter by 1 then exits the parent while loop.

input is 27 --> int of square root is 5 --> first prime factor found is 3. The counter gets incremented to 1. To determine how many other prime factors it would take, I set the `$num` variable to `27 / 3` which is 9 and I exit the `for` loop, restarting it with the new `$num`. In this next iteration the prime found is 3. I increment the counter. Then it goes one more time where it determines that 3 is a prime number and does the final increment. 

```
    while ($calculating) {
	for (my $i = int(sqrt($num)); $i >= 1; $i--) {
	    #looping backwards to find biggest prime factor first
	    if ($num % $i == 0) { #if prime factor found
		$counter++; #increment that we found a prime factor
		$calculating = 0 if ($i == 1); #if the prime factor is 1 stop the parent while loop
		$num = $num / $i; #otherwise reset num lower to search for the next prime factor
		last; #and restart for loop with new number
	    }
	    
	}
    }
```

The full code with comments is available at https://github.com/ianrifkin/perlweeklychallenge-club/blob/ianrifkin-challenge-241/challenge-241/ianrifkin/perl/ch-2.pl