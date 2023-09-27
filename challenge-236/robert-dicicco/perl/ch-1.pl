#!/usr/bin/env perl
use v5.38;
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-25
Challenge 236 Task 01 Exact Change ( Perl )
-------------------------------------
=cut

my @bills = ([5, 5, 5, 10, 20], [5, 5, 10, 10, 20],[5, 5, 5, 20]);

for my $chg (@bills) {
    say "Input: \@bills = [@$chg]";
    my $ln = scalar @$chg;
    my $cnt = 0;
    my $change = 0;
    while ($cnt < @$chg) {
        my $ticket = $chg->[$cnt];
        my $change_required = $ticket - 5;
        if ($ticket == 5){
            $change += 5;
        } elsif ($ticket == 10) {
            $change -= 5;
            $change += 5;
        } elsif ($ticket == 20) {
            if ($change_required > $change){
                say "Output: false\n";
                last;
            } else {
                say "Output: true\n";
                last;
            }
            $change -= 15;
            $change += 5;
        }
        $cnt++;
    }
}
=begin comment
--------------------------------------
SAMPLE OUTPUT
perl .\ExactChange.pl

Input: @bills = [5 5 5 10 20]
Output: true

Input: @bills = [5 5 10 10 20]
Output: false

Input: @bills = [5 5 5 20]
Output: true
-------------------------------------
=cut


