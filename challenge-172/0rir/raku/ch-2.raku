#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use Test;

=begin comment
Task 2: Five-number Summary     Submitted by: Mohammad S Anwar
Given an array of integers, compute the five-number summary of
the given set of integers.

Definition and example in the wikipedia page.
=end comment

# My naive solution gives the same results as the TI-83 calc boxplot.
# (Cannot find the site that details the various methods of calculating
# a five number summary.
# Not finding any definitive information regarding sets of size < 5, and
# not personally finding results of such meaningful, the routine dies.

# input default and response default
my @moon = 0, 0, 1, 2, 63, 61, 27, 13;
my @moon-sumry = 0, 0.5, 7.5, 44, 63;

constant TEST = False;
if TEST {
    my @std = 6,  7, 15, 36, 39,   40,   41, 42, 43, 47,  49;
    my @ti83 = 6, 15, 40, 43, 49;

my @test =
    { in => @std , expect => @ti83 },
    { in => @moon , expect => @moon-sumry },
    { in => [1,2,3,4,5,6,7,8], expect => [1,2.5,4.5,6.5,8] },
    { in => [1,2,3,4,5,6,7,8,9,10,11,12], expect => [1,3.5,6.5,9.5,12] },
    { in => [1,2,3,4,5], expect => [1,1.5,3,4.5,5] },
    { in => [1,2,3,4,5,6,7,8,9], expect => [1,2.5,5,7.5,9] },
    { in => [1,2,3,4,5,6], expect => [1,2,3.5,5,6] },
    { in => [1,2,3,4,5,6,7,8,9,10], expect => [1,3,5.5,8,10] },
    { in => [1,2,3,4,5,6,7], expect => [1,2,4,6,7] },
    { in => [1,2,3,4,5,6,7,8,9,10,11], expect => [1,3,6,9,11] },
    ;
    plan @test.elems;
    for @test -> %h {
        is naive-five-num( %h<in>), %h<expect>, %h<in>;
    }
    done-testing;
    exit;
}

sub naive-five-num( @ary --> Array) {
    my $elems = @ary.elems;
    die "Won't create a summary larger than dataset. NO SPEC" if $elems < 5;
    my @ret;
    my @n = @ary.sort;

    given $elems % 4 {
        @ret[0]= @n[0];
        @ret[4]= @n[* -1];
        my $q2 = Int(@n.end ÷ 2);
        my $q1  = Int( $q2 ÷ 2);
        my $q3  = $q2 + $q1;

        when 0  {   @ret[1..3] = 2 «R÷«
                       (([+] @n[$q1..$q1+1]),
                        ([+] @n[$q2..$q2+1]),
                        ([+] @n[$q3^..$q3+2]));
        }
        when 1  {   @ret[1] = ([+] @n[$q1-1 ..$q1]) ÷ 2;
                    @ret[2] = @n[$q2];
                    @ret[3] = ([+] @n[$q3 ..$q3+1]) ÷ 2;
        }
        when 2  {   @ret[1..3]
                        = @n[$q1], ([+] @n[$q2 ..$q2+1]) ÷ 2, @n[$q3+1];
        }
        when 3  {   @ret[1..3] = @n[$q1], @n[$q2], @n[$q3+1];
        }
    }
    @ret;
}

sub MAIN( @arg = @moon ) {
    say "Input:  ", @arg.raku();
    say "Five-number Summary (TI-83ish):";
    say "        ", naive-five-num( @arg ).raku;

    die "What?!  That's wrong!"   if
        @arg eqv @moon and naive-five-num(@arg) !~~ @moon-sumry;
}


