#!/usr/bin/env perl
=begin comment
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-05
Challenge 237 Task 02 Maximise Greatness ( Perl )
-----------------------------------------
=cut
use v5.38;
use Algorithm::Permute;

my @mynums = ([1, 3, 5, 2, 1, 3, 1], [1, 2, 3, 4]);

my $maxscore = 0;
my $score = 0;

my @output = [];

sub CalcScore ($a,$b) {
    my $cnt = 0;
    my $score = 0;
    while($cnt < scalar @$a) {
        if ($a->[$cnt] < $b->[$cnt]) {
            $score++;
        }
        $cnt++;
    }
    return $score;
}

for my $nums ( @mynums) {
    say "Input: \@nums = [@$nums]";
    $maxscore = 0;
    my @sec = @$nums;
    my $p = Algorithm::Permute->new(\@sec);
    while ( my @perm = $p->next) {
        $score = 0;
        $score = CalcScore($nums, \@perm);
        my $ignore = int((scalar @$nums / 2) + 1);
        if ($score >= $maxscore and $score >= $ignore) {
            $maxscore = $score;
        }
    }
    say "Output: $maxscore\n";
}

=begin comment
-----------------------------------------
SAMPLE OUTPUT
perl .\MaximiseGreatness.pl

Input: @nums = [1 3 5 2 1 3 1]
Output: 4

Input: @nums = [1 2 3 4]
Output: 3
-----------------------------------------
=cut


