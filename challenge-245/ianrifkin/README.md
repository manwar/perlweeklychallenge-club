# Language popularity and largest of 3

Challenge 245: https://theweeklychallenge.org/blog/perl-weekly-challenge-245/

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
```my @pop_sort_idx = sort { $popularity[$a] <=> $popularity[$b] } 0 .. $#popularity;```

With that I return an array of the languages in sort order using the inputted langage array in the order of the sorted popularity:
```@lang[@pop_sort_idx];```

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

---
The full code with comments is available at https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-245/ianrifkin
