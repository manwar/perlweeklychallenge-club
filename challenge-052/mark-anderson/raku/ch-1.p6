#!/usr/bin/env raku

# I learned about polymod from Kevin Colyer's ch-2.p6 solution last week.
# I like that method for splitting up the number into its digits.

sub MAIN($arg1, $arg2 where $arg1 >= 100 < $arg2 <= 999) {
    for ($arg1..$arg2) -> $num {
        my @digits = (+$num).polymod(10,10);
        if (([-] @digits[0,1]).abs == ([-] @digits[1,2]).abs == 1) {
            say $num;
        }
    }
}

# There is a breadth first search solution that I found at 
# https://www.geeksforgeeks.org/stepping-numbers/
# I translated the C++ code into raku below. This is an 
# alternate solution to my usual brute force approach above.

#`[
my @results;

sub MAIN($arg1, $arg2 where $arg1 >= 100 < $arg2 <= 999) {  
    for (0 .. 9) -> $num {
        bfs($arg1, $arg2, $num);
    }  

    @results.sort.join("\n").say;
}

sub bfs(Int $n, Int $m, Int $num) { 
    my @nums; 
  
    @nums.push($num); 
  
    while (@nums) { 
        my $stepNum = @nums.shift; 
  
        if ($m >= $stepNum >= $n) {
            @results.push($stepNum);
        }
 
        if ($num == 0 || $stepNum > $m) {
            next; 
        }
  
        my $lastDigit = $stepNum % 10; 
  
        my $stepNumA = $stepNum * 10 + ($lastDigit - 1); 
        my $stepNumB = $stepNum * 10 + ($lastDigit + 1); 
  
        if ($lastDigit == 0) { 
            @nums.push($stepNumB); 
        }
  
        elsif ($lastDigit == 9) { 
            @nums.push($stepNumA); 
        }
  
        else { 
            @nums.push($stepNumA); 
            @nums.push($stepNumB); 
        } 
    } 
} 
]
