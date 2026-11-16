<<<<<<< HEAD
# I'm never last picked

Challenge 245: https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

This week we have a task to sort an array based on another array and a task to calculate the largest number combination from a given input that is divisible by 3.

## Task 1: Sort Language

```
You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

Example 1
Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')
Example 2
Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')
```

My first instinct to solve this was to align the two arrays (lang and popularity) into a hash. While this made sense I quickly realized I would still have the step of sorting based on the keys. This should still have worked but since the arrays have the same indices I didn't really need to combine them into a hash.

I sorted the popularity array and outputted the indices in sort order (not the values):
```
my @pop_sort_idx = sort { $popularity[$a] <=> $popularity[$b] } 0 .. $#popularity;
```

With that I return an array of the languages in sort order using the inputted langage array in the order of the sorted popularity:
```
@lang[@pop_sort_idx];
```

I also solved this task only slightly differently with Python. I first created a list combining the `popularity` and `lang` lists using `zip`:
```
sorted_langs_with_pop = sorted(zip(popularity,lang))
```

I then use that to create the desired output of just the languages in the sort order:
```
[lang for _,lang in sorted_langs_with_pop]
```

That could have been in one line but I thought it was clearer in the two distinct steps.

## Task 2: Largest of Three

```
You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the given integers in any order which is also multiple of 3. Return -1 if none found.


Example 1
Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0
Example 2
Input: @ints = (8, 6, 7, 1, 0)
Output: 8760
Example 3
Input: @ints = (1)
Output: -1
```

This was fun to think through. The first part of the problem is to create an array of all potential numbers sorted from biggest to smallest. The second part of the problem is simpler -- ouput the biggest number (if available) that is divisible by 3.

In Challenge 244 I used Algorithm::Combinatoric::partitions so I decided to start with that again here. I take the input number and use `partitions` to generate the various "partitions" e.g. for 9,8,1 it is: 981, 98, 91, 9, 81, 8, 1.
```
my @parts = partitions(\@ints);
```

This only gets me part of the way there. I then need each of those numbers in every order (e.g. I need 89 in addition to 98). I decided to use Algorithm::Permute to take the partitions and create all these permutations. 
```
for (my $i=0; $i<@parts-1; $i++) {
    foreach ( @{$parts[$i]} ) {
        my @parts = $_;
	    my $p_iterator = Algorithm::Permute->new ( \@{$parts[0]} );
```

Finally I will take the output from Algorithm::Permute and push it into an array of all the numbers to try:
```
while (my @perm = $p_iterator->next) {
      push(@numbers_to_try, join('', @perm));
}	    
```

At this point I have a randomly sorted array of every number to try. I next need to find out which number (if any) is the largest number divisible by 3.
```
foreach my $num_2_try (sort { $b <=> $a } @numbers_to_try) {
  return $num_2_try unless $num_2_try % 3;
}
```

The above loop will return the first number (the largest number) divisible by 3. If it doesn't find one then after this loop there is a `return -1` so that the default behavoir matches the requirements.


Again with this task I wanted to see how to solve it using Python. It is a fairly similar approach but I of course don't have the Perl modules available; instead I used `itertools:permutations` which is native to Python.

`itertools:permutations` can have a length to its output but I don't see a way for it to provide a dynamic length like we need. Instead I loop through the list length so that I can run the permutations for each length:
```
for i in range(len(nums)):
    num_of_digits = i+1
    perms = list(permutations(nums, num_of_digits))
```

That creates a list of tuples, but I need the tuples to be combined into actual numbers to try:
```
    for group_of_digits in perms:
        combined_digits = int("".join(map(str, group_of_digits)))            
        numbers_to_try.append(combined_digits)
```

Now I have an unsorted list of numbers to try, so next comes the sorting:
```
numbers_to_try.sort(reverse=True)
```

The final step, like in the Perl solution, is to return the first (largest) number divisible by 3, otherwise return -1:
```
for num2try in numbers_to_try:
    if num2try % 3 == 0:
       return num2try
return -1
```


---
The full code with comments is available at https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-245/ianrifkin
=======
# And then a hero comes along

Challenge 244: https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

This task was during the week of American Thanksgiving so I may not be fully present with my responses. The first task seemed straightforward enough so let's start with that one.

## Task 1: Count Smaller

```
You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at each index.

Example 1
Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.
Example 2
Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)
Example 3
Input: @int = (2, 2, 2)
Output: (0, 0, 0)
```

I solve this by looping through the `@int` array and creating an array for the output for each numbers total of numbers that are smaller than it (defaulting it to 0):
```
for (my $i=0; $i < @int; $i++) {
    $int_out[$i] = 0; #default is no number is smaller than it
```

Then I loop through the `@int` array again, this time to check each number in the array (except for itself) and increment the output number when needed:
```
for (my $j=0; $j < @int; $j++) {	
    $int_out[$i]++ if ($int[$i] > $int[$j] && $i != $j);
}
```

That's it! Other than that it's just calling the sub and outputting it in the desired format.


## Task 2: Group Hero

```
You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations; power is defined as the square of the largest number in a sequence, multiplied by the smallest.


Example 1
Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
```

This task was a lot more challenging for me and I'm not entirely sure I am solving it in a sane manner, but I do appear to get the correct output.

I created a subroutine `group_hero` which accepts the input array. I then use `Algorithm::Combinatorics qw(partitions)` to create the different number combinations. Is this cheating? Maybe, but I'm okay with it. Don't worry, it's not the only "cheat" I used in this one. I also use `List::Util qw( min max )` to calculuate the min and max values in an array!

So I start byt creating the number combinations: `my @parts = partitions(\@nums);`

The final array element in `@parts` is duplicative for our purposes so I ignore that. I loop through the rest of the parts: `for (my $i=0; $i<@parts-1; $i++) {`

Each `$parts[$i]` is an array of the desired combinations so I loop through that: `foreach ( @{$parts[$i]} ) {`

Within this final loop I calculate the min, max and perform the math:
```
my $min = min @{$parts[0]};
my $max = max @{$parts[0]};
$group_hero += $max**2 * $min;
```

Then at the conclusion I return `$group_hero` with the final number.

---
The full code with comments is available at https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-244/ianrifkin
>>>>>>> main
