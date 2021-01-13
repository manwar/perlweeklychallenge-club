#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Time::HiRes 'time';
   
my $start_time = time;
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

my $elapsed = time - $start_time;
printf ("Execution Time: %.6f seconds",$elapsed);
=begin
perl .\ch-2.pl 
2 1 4 3
3 2 4 1
3 1 4 2
4 2 3 1
4 1 3 2
Execution Time: 0.001008 seconds

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
Execution Time: 0.002978 seconds

perl .\ch-2.pl 1 2 3 4 5 6 7 8 9
...
9 1 8 2 7 3 5 4 6
9 1 8 2 7 3 6 4 5
9 1 8 2 7 4 5 3 6
9 1 8 2 7 4 6 3 5
9 1 8 2 4 3 7 5 6
9 1 8 2 4 3 6 5 7
Execution Time: 7.181952 seconds

perl .\ch-2.pl 1 2 3 4 5 6 7 8 9 10
...
10 1 9 2 8 4 6 3 7 5
10 1 9 2 4 3 7 6 8 5
10 1 9 2 4 3 7 5 8 6
10 1 9 2 4 3 8 6 7 5
10 1 9 2 4 3 8 5 7 6
10 1 9 2 4 3 6 5 8 7
Execution Time: 52.477920 seconds
=cut
