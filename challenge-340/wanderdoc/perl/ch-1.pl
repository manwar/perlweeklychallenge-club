#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, consisting of lowercase English letters.

Write a script to return the final string after all duplicate removals have been made. Repeat duplicate removals on the given string until we no longer can.

    A duplicate removal consists of choosing two adjacent and equal letters and removing them.


Example 1

Input: $str = 'abbaca'
Output: 'ca'

Step 1: Remove 'bb' => 'aaca'
Step 2: Remove 'aa' => 'ca'


Example 2

Input: $str = 'azxxzy'
Output: 'ay'

Step 1: Remove 'xx' => 'azzy'
Step 2: Remove 'zz' => 'ay'


Example 3

Input: $str = 'aaaaaaaa'
Output: ''

Step 1: Remove 'aa' => 'aaaaaa'
Step 2: Remove 'aa' => 'aaaa'
Step 3: Remove 'aa' => 'aa'
Step 4: Remove 'aa' => ''


Example 4

Input: $str = 'aabccba'
Output: 'a'

Step 1: Remove 'aa' => 'bccba'
Step 2: Remove 'cc' => 'bba'
Step 3: Remove 'bb' => 'a'


Example 5

Input: $str = 'abcddcba'
Output: ''

Step 1: Remove 'dd' => 'abccba'
Step 2: Remove 'cc' => 'abba'
Step 3: Remove 'bb' => 'aa'
Step 4: Remove 'aa' => ''
=cut

use Test2::V0 -no_srand => 1;
is(duplicate_removal('abbaca'), 'ca', 'Example 1');
is(duplicate_removal('azxxzy'), 'ay', 'Example 2');
is(duplicate_removal('aaaaaaaa'), '', 'Example 3');
is(duplicate_removal('aabccba'), 'a', 'Example 4');
is(duplicate_removal('abcddcba'), '', 'Example 5');
done_testing();

sub duplicate_removal
{
     my $str = $_[0];
     while ( $str =~ /(.)\g{1}/ )
     {
          $str =~ s/(.)\g{1}//;
     }
     return $str;
}
