use v5.38;
use Data::PowerSet "powerset";
use List::Util "sum";

sub proc(@nums) {
    say "Input: @nums";
    my $indexset = powerset(1 .. @nums);
    my $powerset = powerset(@nums);
    say "Output: ";
    for my $i (0 .. scalar(@$powerset) - 1) {
	my @I = map{ @$_ } @$indexset[$i];
	my @L = map{ @$_ } @$powerset[$i];
	next if (scalar @I == 0);
	my $sum1 = sum(@I);
	my $sum2 = sum(@L);
	if ($sum1 == $sum2) {
	    say "@L";
	}
    }
}

my @nums = (2, 1, 4, 3);
proc(@nums);
@nums = (3, 0, 3, 0);
proc(@nums);
@nums = (5, 1, 1, 1);
proc(@nums);
@nums = (3, -1, 4, 2);
proc(@nums);
@nums = (10, 20, 30, 40);
proc(@nums);


