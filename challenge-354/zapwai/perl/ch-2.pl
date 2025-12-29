use v5.38;

sub proc($k, @matrix) {
    say "Input:  \$k = $k";
    say "\t[" . join(",",@$_) . "]" for (@matrix);
    my $m = @matrix;
    my $n = @{$matrix[0]};
    my @l;		  # list of all numbers, we shift and reassign
    for my $row (@matrix) {
	for my $item (@$row) {
	    push @l, $item;
	}
    }
    push @l, shift @l;
    say @l;
    say "Output: ";
    my @out;
    for my $i (1 .. $m) {
	my @row;
	for my $j (1 .. $n) {
	   push @row, shift @l;
       }
	push @out, \@row;
    }
    say @$_ for (@out);
}

my @matrix = ([1, 2, 3],
	      [4, 5, 6],
	      [7, 8, 9],);
my $k = 1;
proc($k, @matrix);
@matrix = ([10, 20],
	   [30, 40],);
proc($k, @matrix);
@matrix = ([1, 2],
	   [3, 4],
	   [5, 6],);
proc($k, @matrix);
@matrix = ([1, 2, 3],
	   [4, 5, 6],);
proc($k, @matrix);
@matrix = ([1, 2, 3, 4]);
proc($k, @matrix);
