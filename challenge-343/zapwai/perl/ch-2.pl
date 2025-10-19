use v5.38;
use List::Util "sum";

sub proc(@g) {
    say "Input: ";
    my $row_max = 0;
    my $row = 0;
    my $o = 0;
    for my $r (@g) {
	my $s = sum(@$r);
	if ($s > $row_max) {
	    $row_max = $s;
	    $o = $row;
	}
	$row++;
    }
    say "Output: Team $o (with $row_max wins)";
}

my @grid = (
    [0, 1, 1],
    [0, 0, 1],
    [0, 0, 0],
);
proc(@grid);
@grid = (
    [0, 1, 0, 0],
    [0, 0, 0, 0],
    [1, 1, 0, 0],
    [1, 1, 1, 0],
);
proc(@grid);
@grid = (
    [0, 1],
    [0, 0],
);
proc(@grid);
@grid = (
    [0, 1, 1],
    [0, 0, 0],
    [0, 1, 0],
);
proc(@grid);
@grid = (
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 1, 1],
    [1, 1, 0, 0, 0],
    [1, 1, 0, 1, 0],
);
proc(@grid);
