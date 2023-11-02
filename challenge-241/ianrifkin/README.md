# Math is hard

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

I started by looping through the input array with an incrementer `$i`. We know that $i is needed for the first value so the max $i is going to be 2 less than the total array length: `for (my $i = 0; $i < $nums_length - 2; $i++)`

Within this loop I just make the next loop with `$j` which is 1 more than `$i` to 1 less than the array length: `for (my $j = $i + 1; $j < $nums_length - 1; $j++)`

Finally within that loop I create the loop with `$k` which is going to be 1 more than `$j` to the end of the array: `for (my $k = $j + 1; $k < $nums_length; $k++)`

Now that I have my loops I go back to the instructions which stated:
nums[j] - nums[i] == diff
and
nums[k] - nums[j] == diff

which in my Perl code is simple: `(@{$nums}[$j] - @{$nums}[$i] eq $diff && @{$nums}[$k] - @{$nums}[$j] eq $diff)`

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

This one sounded simple enough but I needed to write WAY more code to accomplish. Though to be fair, part of the length is a lot more code commends and documentation.

I split up the work into 2 subroutines. The second one is simpler so let's talk about that first. I created a `prime_finder` to accept a number and output its prime.

In the sub I have a for loop where the iterator goes from 2 to the square root of the number, which I calculated with the sqrt() function. I have it find the prime by taking the number and dividing by the iterator and seeing if it equals 0.

When it finds the prime instead of returning that value I'm returning the number / that prime iterator value so that I can use it later to calcuate the remaining values.

For example, given the input 8 it will find the value 2 then return 4 (because 8/2=4). This will allow the other subroutine to calculate the complete list: 2,2,2 for input 8.

The only other things that `prime_finder` does is if $num % $i does not equal to 0 in any of the loops then that means that the input number was actually prime so it will return the input number.

```
sub prime_finder {
    my ($num) = @_;
    my $num_was_prime;
    for (my $i = 2; $i <= sqrt($num); $i++) {
        if ($num % $i == 0) {
            return $num / $i;
            $num_was_prime = 0;
            last;
        }
        else {
            $num_was_prime = 1;
        }

    }
    return $num if $num_was_prime;
}
```

The subroutine that calls the above and does the sorting and output printing took a notable amount of time to think through and test and troubleshoot, especially since I wanted it to work for any input (and any amount of input).

The sub accepts the input array of numbers and loops through each one. It creates a hash `%results` to store the count of prime factors for each number.

The loop starts by setting `$results{$num} = 1;` because every number will have at least the prime factor of itself.

Next I use the `prime_finder()` sub on the input number to get the value.

If the `prime_finder()` value is undefined or equal to the input number, we're done and can proceed to the next number in the loop.

If `prime_finder()` returned a new number I increment `$results{$num}` to account for the smallest factor than loop to find the remaining factors, if applicable.

The loop goes from the initial value returned by `prime_finder()` to the value of the input number devided by that `prime_finder()` value, which should be the smallest factor (hence why I already incremented for the smallest factor above).

In the loop I calculate the next prime with `prime_finder()` then either increment the counter or exit the loop if no new prime is found. If a prime was found, in addition to incrementing the counter I then loop back through using the new `prime_finder()` value.

With all the looping complete I sort the `%results` hash first by its values (the counter) then do a secondary sort on the key (the input number), which I save in an array. I am assuming that `tie-breaking by ascending value` mean the value of the input number. At the end I just print the `@sorted_output` array.

The full code with comments is available at https://github.com/ianrifkin/perlweeklychallenge-club/blob/ianrifkin-challenge-241/challenge-241/ianrifkin/perl/ch-2.pl