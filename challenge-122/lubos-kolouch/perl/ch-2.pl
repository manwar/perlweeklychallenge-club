#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw/sum/;
use feature qw/say/;
# Perl weekly challenge 122 Task 2 - Basketball Points

my $iter_count = 0;

sub iterate {  

    my ($arr, $target_sum) = @_;
    my $arr_sum = sum(@$arr) || 0;

    if ($arr_sum == $target_sum) {
        print "*********** SCORE: ";
        say join " ", @$arr;       
        $iter_count++;
    }

    return if $arr_sum >= $target_sum;

    # expand the array and try again
    my @new_arr = @$arr;
    push @new_arr, 1;
    print join " ", @$arr;       
    print " > ";
    say join " ", @new_arr;       
    iterate((\@new_arr, $target_sum));

    # cannot expand, try increasing the last poing
    my @new_arr = @$arr;
    if ( (@new_arr) and ($new_arr[-1] < $target_sum) and ($new_arr[-1] < 3) ) { 
        $new_arr[-1]++;
        print join " ", @$arr;       
        print " ^ ";
        say join " ", @new_arr;       
        iterate((\@new_arr, $target_sum));
    }

}


sub print_points {
    my $target_sum = shift;
    iterate(([], $target_sum));




}

use Test::More;

$iter_count = 0;
print_points(4);
is($iter_count, 7);

$iter_count = 0;
print_points(5);
is($iter_count, 13);

done_testing;
