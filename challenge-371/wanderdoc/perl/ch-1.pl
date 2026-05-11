#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a sequence of 5 lowercase letters, with one letter replaced by ‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’, …, ‘z = 26’). The sequence follows a repeating pattern of step sizes between consecutive letters. The pattern is either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).
Example 1

Input: @seq = qw(a c ? g i)
Output: e

The pattern of the sequence is +2,+2,+2,+2.
1: a
3: c
5: e
7: g
9: i

Example 2

Input: @seq = qw(a d ? j m)
Output: g

The pattern of the sequence is +3,+3,+3,+3.
1: a
4: d
7: g
10: j
13: m

Example 3

Input: @seq = qw(a e ? m q)
Output: i

The pattern of the sequence is +4,+4,+4,+4.
1: a
5: e
9: i
13: m
17: q

Example 4

Input: @seq = qw(a c f ? k)
Output: h

The pattern of the sequence is +2,+3,+2,+3.
1: a
3: c
6: f
8: h
11: k

Example 5

Input: @seq = qw(b e g ? l)
Output: j

The pattern of the sequence is +3,+2,+3,+2.
2: b
5: e
7: g
10: j
12: l
=cut

use List::MoreUtils qw(only_index); 
use Test2::V0 -no_srand => 1;

is(missing_letter (qw(a c ? g i)), 'e', 'Example 1');
is(missing_letter (qw(a d ? j m)), 'g', 'Example 2');
is(missing_letter (qw(a e ? m q)), 'i', 'Example 3');
is(missing_letter (qw(a c f ? k)), 'h', 'Example 4');
is(missing_letter (qw(b e g ? l)), 'j', 'Example 5');

is(missing_letter (qw(? c d f g)), 'a', 'Example 6');
is(missing_letter (qw(a c d f ?)), 'g', 'Example 7');
is(missing_letter (qw(a ? d f g)), 'c', 'Example 8');
is(missing_letter (qw(? b e f i)), 'a', 'Example 9');
is(missing_letter (qw(a b e f ?)), 'i', 'Example 10');

done_testing();

sub missing_letter
{
     my @seq = @_; 
     my $counter;
     my %letters = map {$_ => ++$counter} 'a' .. 'z';

     my %numbers = reverse %letters;
     my $question_idx = only_index { $_ eq '?' } @seq;
     die "Something is wrong" if $question_idx == -1;
     
     my %slide = 
     map { $_ =>  (exists $letters{$seq[$_]} and exists $letters{$seq[$_ - 1]})  ? 
                    $letters{$seq[$_]} - $letters{$seq[$_ - 1]} : undef
     } 1 .. $#seq;
     
     my @defined_keys = grep {defined $slide{$_}} keys %slide;
     my %odd_even = map {$_ % 2 => $slide{$_}} @defined_keys;
     
     my $idx_left_of = $question_idx > 0 ? $question_idx - 1 : undef;
     my $idx_right_of = $question_idx < $#seq ? $question_idx + 1 : undef;
     
     my $reference_idx = $idx_left_of // $idx_right_of;
     my $step = $question_idx > 0 ? $odd_even{$question_idx % 2} : $odd_even{$idx_right_of % 2};  
     
     my $missing_num = $question_idx > 0 ? 
          $letters{$seq[$reference_idx]} + $step :
          $letters{$seq[$reference_idx]} - $step;
     my $missing_letter = $numbers{$missing_num};
     return $missing_letter;
}
