#!/usr/bin/env raku

# A breadth first search solution at 
# https://www.geeksforgeeks.org/stepping-numbers/
# The C++ code translated to Raku.  

sub MAIN($arg1, $arg2 where $arg1 >= 100 < $arg2 <= 999) {  
    my @results;

    for (0 .. 9) -> $num {
        bfs($arg1, $arg2, $num, @results);
    }  

    @results.sort.join("\n").say;
}

sub bfs(Int $n, Int $m, Int $num, @results) { 
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

# A bonus brute force solution

#sub MAIN($arg1, $arg2 where $arg1 >= 100 < $arg2 <= 999) {
#    for ($arg1..$arg2) -> $num {
#        my @digits = (+$num).polymod(10,10);
#        if (([-] @digits[0,1]).abs == ([-] @digits[1,2]).abs == 1) {
#            say $num;
#        }
#    }
#}
