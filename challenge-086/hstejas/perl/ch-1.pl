#!/usr/bin/env perl
use strict;
use warnings;
use v5.30;

sub pair_diff {
    my $ref = abs(shift);
    my @nums = sort { $b <=> $a } @{ shift @_ };

    while(@nums) {
        my $num = shift @nums;
        foreach(@nums) {
            my $diff = abs($num - $_);
            if($diff == $ref) {
                say "1 as $num - $_ = $ref";
                return;
            }
            elsif($diff > $ref) {
                last;
            }
        }
    }
    say '0';
}

my $tests = {
    'Test1' => { 'ref' => 7, 'arr' => [10, 8, 12, 15, 5] },
    'Test2' => { 'ref' => 6, 'arr' => [1, 5, 2, 9, 7] },
    'Test3' => { 'ref' => 15, 'arr' => [10, 30, 20, 50, 40] },
    'Test4' => { 'ref' => 15, 'arr' => [-15, -5, -30, 20, 50, 40] },
    'Test5' => { 'ref' => -15, 'arr' => [-15, -5, -30, 20, 50, 40] },
    'Test6' => { 'ref' => 1, 'arr' => [9, map { $_ * 10 } 1..900000 ] },
};

foreach(sort keys %{$tests}) {
    my $test = $tests->{$_};
    pair_diff($test->{'ref'}, $test->{'arr'});
}