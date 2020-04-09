#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';


my @n = sort {$a - $b} @ARGV ? @ARGV : (1, 2, 3, 4) ;
my %h;
sub wave {  
    my ($a,$l,$r) = @_;
 
    if ($l == $r) {
        my $flag = 1;
        for my $e (1..$#{$a}) {
            !($flag &= $e % 2? $a->[$e]<=$a->[$e-1] : $a->[$e]>=$a->[$e-1]) && last;   
        }
        
        #Only unique permutation will be printed
        $flag && !$h{"@{$a}"}++ && say "@{$a}"
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
2 2 3 1 4
2 2 4 1 3
3 2 2 1 4
3 2 4 1 2
3 1 2 2 4
3 1 4 2 2
4 2 2 1 3
4 2 3 1 2
4 1 2 2 3
4 1 3 2 2
=cut
