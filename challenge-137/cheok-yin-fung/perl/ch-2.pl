#!/usr/bin/perl
# The Weekly Challenge 137
# Task 2 Lychrel Number
# Usage: $ ch-2.pl $n
use v5.12.0;
use warnings;
use Test::More tests => 5;

say lych($ARGV[0]) if defined($ARGV[0]);



sub lych {
    my $itor = 0;
    my $num = $_[0];

    while (   (reverse $num) ne $num 
            && $itor < 500 
            && $num < 10_000_000 
          ) {
        $num = $num + reverse $num;
    }

    return( ((reverse $num) eq $num )? 0 : 1 );
}



ok lych(56) == 0, "Example 1";
ok lych(57) == 0, "Example 2";
ok lych(59) == 0, "Example 3";
ok lych(1001) == 0, "itself palindrome";
ok lych(196) == 1, "famous 196 undetermined";
