#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';


my @n       = @ARGV ? @ARGV : (1, 2, 3, 4) ;

sub wave {  
    my ($a,$l,$r) = @_;
 
    if ($l == $r) {
        if ($a->[1]<=$a->[0]) {
            #This filter assumes numbers in array @n are unique. 
            #So, combinations like [2, 2, 1, 4, 3] will not be
            #generated/printed when given @n = [1, 2, 2, 3, 4]
            (!grep { 
                (
                    ($a->[$_]   >= $a->[$_-1]) && 
                    ($a->[$_-1] >= $a->[$_-2])
                ) or (
                    ($a->[$_]   <= $a->[$_-1]) && 
                    ($a->[$_-1] <= $a->[$_-2])
                ) 
            } 2..$#{$a}) && say "@{$a}";
        }
    } else {  
        for my $i ($l..$r) {  
            ($a->[$l], $a->[$i]) = ($a->[$i],$a->[$l]);
            wave($a, $l+1, $r);  
            ($a->[$l], $a->[$i]) = ($a->[$i],$a->[$l]);
        }  
    }  
}  
  
wave(\@n, 0, $#n); 
=begin
perl .\ch-2.pl 
2 1 4 3
3 2 4 1
3 1 4 2
4 2 3 1
4 1 3 2

perl .\ch-2.pl 1 2 2 3 4
2 1 3 2 4
2 1 4 2 3
2 1 3 2 4
2 1 4 2 3
3 2 4 1 2
3 2 4 1 2
4 2 3 1 2
4 2 3 1 2
=cut
