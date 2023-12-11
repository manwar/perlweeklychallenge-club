use v5.30;
my @nums;
do {
    my $x = 1 + int rand 49;
    unless ( grep(/$x/, @nums) ) {
	push @nums, $x;
    }
} while (@nums != 6);
say join(", ", sort {$a <=> $b} @nums);
