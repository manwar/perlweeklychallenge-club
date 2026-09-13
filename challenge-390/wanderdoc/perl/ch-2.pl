#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $s (containing only alphabetic characters) and an integer $k > 0.

Write a script to choose one of the first $k letters of given string and append it at the end of the string. You keep doing this until you have lexicographically smallest string and return the string.
Example 1

Input: $str = "dbca", $k = 1
Output: "adbc"

Move 1: "bcad"
Move 2: "cadb"
Move 3: "adbc"

Example 2

Input: $str = "geeks", $k = 2
Output: "eegks"

First 2 letters: "g", "e"

Move 1: "gekse" (move second letter "e")
Move 2: "gksee" (move second letter "e")
Move 3: "kseeg"
Move 4: "seegk"
Move 5: "eegks"

Example 3

Input: $str = "cbaed", $k = 3
Output: "abcde"

First 3 letters: "c", "b", "a"

Move 1: "cbeda"  (move "a")
Move 2: "cedab"  (move "b")
Move 3: "edabc"  (move "c")
Move 4: "eabcd"  (move "d")
Move 5: "abcde"  (move "e")

Example 4

Input: $str = "fedcba", $k = 4
Output: "abcdef"

First 4 letters: "f", "e", "d", "c"

Move 1: "fdcbae" (move "e")
Move 2: "dcbaef" (move "f")
Move 3: "dcbefa" (move "a")
Move 4: "dcefab" (move "b")
Move 5: "defabc" (move "c")
Move 6: "efabcd" (move "d")
Move 7: "fabcde" (move "e")
Move 8: "abcdef" (move "f")

Example 5

Input: $str = "perl", $k = 1
Output: "erlp"

Move 1: "erlp" (move "p")

Example 6

Input: $str = "oloolooo", $k = 1
Output: "looloooo"

Example 7

Input: $str = "oloooolo", $k = 1
Output: "looloooo"
=cut






use Test2::V0 -no_srand => 1;


is(order_characters("dbca", 1), "adbc", "Example 1");
is(order_characters("geeks", 2), "eegks", "Example 2");
is(order_characters("cbaed", 3), "abcde", "Example 3");
is(order_characters("fedcba", 4), "abcdef", "Example 4");
is(order_characters("perl", 1), "erlp", "Example 5");
is(order_characters("oloolooo", 1), "looloooo", "Example 6");
is(order_characters("oloooolo", 1), "looloooo", "Example 7");
done_testing();

sub order_characters 
{
     my ($str, $k) = @_;
     my $smallest = $str;
     my %seen = ($str => undef);

     my @stack = ($str);
    
     while (@stack) 
     {
          my $this = pop @stack;
          for my $i (0 .. $k - 1) 
          {
               my $next = substr($this, 0, $i) . 
                          substr($this, $i + 1) . 
                          substr($this, $i, 1);
            
               next if exists $seen{$next};
            
               if ($next lt $smallest) 
               {
                    $smallest = $next;
               }
               $seen{$next} = undef;
               push @stack, $next;
          }
     }
     return $smallest;
}
