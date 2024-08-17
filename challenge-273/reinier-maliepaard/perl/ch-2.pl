#!/usr/bin/perl
use strict;
use warnings;

=begin
 I prefer not to replicate the interesting regex solutions of others.
 Therefore, I chose a different approach using the 'index' method.

    Postulate 1: The string must contain at least one 'b'. Strings like
                 'b', 'bb', 'bbb', etc., are also valid.
    Postulate 2: If a string contains the characters 'a' and 'b', then
                 'a' is not allowed to follow the first 'b'. There are
                 two cases to consider:
                 1. If 'ba' appears at the beginning of a string, it
                    should be evaluated as 'false'.
                 2. If 'ba' appears elsewhere in the string, it must be
                    preceded by another 'b' to be evaluated as 'true'.
                    For instance, 'aaba' is 'false' but 'aabba' is 'true'.

 Performance: benchmarking my solution against several regex solutions I
 found on GitHub showed that it performs adequately. It is neither the
 fastest nor the slowest.
=cut

sub BafterA {

 # 'b' in $_[0]?
 return(0) if(index($_[0], "b") == -1);
 # 'ba' at the beginning of $_[0]
 return(0) if(index($_[0], "ba") == 0);
 # 'bba'? 'aba' not allowed
 return(0) if ((index($_[0], "ba") > 0) && (substr($_[0], (index($_[0], "ba")-1), 1) ne "b"));
 1;
}

# TESTS

my $str;

# Example 1
$str = "aabb";
print(BafterA($str), "\n"); # Output: 1

# Example 2
$str = "abab";
print(BafterA($str), "\n"); # Output: 0

# Example 3
$str = "aaa";
print(BafterA($str), "\n"); # Output: 0

# Example 4
$str = "bbb";
print(BafterA($str), "\n"); # Output: 1

# Own tests

# Example 5
$str = "b";
print(BafterA($str), "\n"); # Output: 1

# Example 6
$str = "a";
print(BafterA($str), "\n"); # Output: 0

# Example 7
$str = "ba";
print(BafterA($str), "\n"); # Output: 0

# Example 8
$str = "ab";
print(BafterA($str), "\n"); # Output: 1

# Example 9
$str = "bba";
print(BafterA($str), "\n"); # Output: 1

# Example 10
$str = "aba";
print(BafterA($str), "\n"); # Output: 0

# Example 11
$str = "abba";
print(BafterA($str), "\n"); # Output: 1

# Example 12
$str = "babba";
print(BafterA($str), "\n"); # Output: 0
