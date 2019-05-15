use v6.d;

say 'Challenge 1';
say 'The following numbers between 0 and 50 inclusive are divisible by the sum of their digits';
.say if ($_ %% [+] .comb) for 0..50;
