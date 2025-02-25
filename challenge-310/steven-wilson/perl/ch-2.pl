#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub sortOddEven{
    my $ints_ref = shift;
    my @ints = @$ints_ref;
    my (@even, @odd);

    for my $i (0..scalar @ints - 1){
        if($i % 2 == 0) {
            push @even, $ints[$i];
        }
        else {
            push @odd, $ints[$i];
        }
    }

    my @even_sorted = sort { $a <=> $b } @even;
    my @odd_sorted = sort { $b <=> $a } @odd;
    my @result = ();

    for my $i (0..scalar @ints - 1){
        if($i % 2 == 0){
            push @result, shift @even_sorted;
        }
        else {
            push @result, shift @odd_sorted;
        }
    }
    return @result;
}

is_deeply([sortOddEven([4, 1, 2, 3])], [2, 3, 4, 1], "Example 1");
is_deeply([sortOddEven([3, 1])], [3, 1], "Example 2");
is_deeply([sortOddEven([5, 3, 2, 1, 4])], [2, 3, 4, 1, 5], "Example 3");

done_testing();
