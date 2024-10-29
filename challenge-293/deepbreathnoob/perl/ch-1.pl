#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my @dominos1 = ([1, 3], [3, 1], [2, 4], [6, 8]);
my @dominos2 = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]);
my @dominos3 = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 5], [1, 3], [2, 1], [5, 2],[7,5], [7,5], [7,5]);

print "Number of Dominos: ".check_dominos(@dominos2)."\n";
print "Number of Dominos: ".check_dominos(@dominos1)."\n";
print "Number of Dominos: ".check_dominos(@dominos3)."\n";

sub check_dominos {
    my @dom = @_;
    my $counter = 1;
    my $previous;
    my @new_arr_of_strings;
    my $sum = 0;
    foreach my $item (@dom){
        my @arr = @$item;
        my @sorted_arr = sort { $a <=> $b } @arr;
        my $string = join("", @sorted_arr);
        push(@new_arr_of_strings, $string);
    }
    my @new_sorted_arr_of_strings = sort { $a <=> $b } @new_arr_of_strings;
    foreach my $strin_item (@new_sorted_arr_of_strings){
        if(defined($previous)){
            if($previous eq $strin_item){
                $counter++;
                $previous = $strin_item;
            }else{
                if($counter > 1) {
                    $sum = $sum + $counter;
                }
                $counter = 1;
                $previous = $strin_item;
            }
        }else{
            $counter = 1;
            $previous = $strin_item;
        }
    }
    if($counter > 1){
        $sum += $counter;
    }
    return $sum;
}
