#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 391 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Array Median

You are given two sorted arrays.

Write a script to merge the two given sorted arrays and return the median of the merged array.

=head3 Example 1:

Input: @arr1 = (2), @arr2 = (4)
Output: 3.0

Merged array: (2,4)
Median: (2+4)/2 => 3

=head3 Example 2:

Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
Output: 7.0

Merged array: (1,2,3,7,8,9,10)
Length of merged array is 7, the 4th element is 7.

=head3 Example 3:

Input: @arr1 = (), @arr2 = (10,20,30,40)
Output: 25.0

Merged array: (10,20,30,40)
Median: (20+30)/2 => 25

=head3 Example 4:

Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
Output: 4.5
y
Merged array: (1,2,3,4,5,6,7,100)
Median: (4+5)/2 => 4.5

=head3 Example 5:

Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
Output: 2.0

Merged array: (1,2,2,2,2,3)
Median: (2+2)/2 => 2

=end pod

sub valid(@arr1, @arr2 --> Bool) {
    return False unless @arr1.elems > 0 || @arr2.elems > 0;
    return False unless @arr1.all ~~ Int && @arr2.all ~~ Int;
    True;
}

sub array-median(@arr1, @arr2 --> Rat) {
    die "Unexpected inputs { @arr1.raku } { @arr2.raku }" unless valid(@arr1, @arr2);
    my @merged = flat(@arr1, @arr2).sort;
    my $n = @merged.elems;
    my $middle = $n div 2;
    my $median = $n %% 2 ?? (@merged[$middle - 1] + @merged[$middle]) / 2
                         !! @merged[$middle];
    $median.Rat;
}

#| merge comma separated ARR1 and ARR2 and compute the median
multi MAIN(Str:D $arr1, Str:D $arr2) {
    say array-median($arr1.split(',').map({ .Int }).Array,
                     $arr2.split(',').map({ .Int }).Array);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ([2], [4]), output => 3.0 ));
    @tests.push(%( input => ([1, 2, 3], [7, 8, 9, 10]), output => 7.0 ));
    @tests.push(%( input => ([], [10, 20, 30, 40]), output => 25.0 ));
    @tests.push(%( input => ([100], [1, 2, 3, 4, 5, 6, 7]), output => 4.5 ));
    @tests.push(%( input => ([1, 2, 2], [2, 2, 3]), output => 2.0 ));
    my @should-throw;
    @should-throw.push(%( input => ([], []) ));
    @should-throw.push(%( input => ([1, 2], ["a"]) ));
    @should-throw.push(%( input => (["a", 2], [1]) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is array-median(|.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { array-median(|.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1, 1', '2, 2', :out, :err);
    is $proc.out.slurp(:close).trim, '1.5', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
