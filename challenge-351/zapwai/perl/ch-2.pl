use v5.38;

sub proc(@num) {
    say "Input: \@num = @num";
    @num = sort {$a <=> $b} @num;
    my $diff = $num[1] - $num[0];
    my $o = "true";
    for my $i (1 .. $#num - 1) {
	$o = "false" if ($num[$i + 1] - $num[$i] != $diff);
    }
    say "Output: $o";
}

my @num = (1, 3, 5, 7, 9);
proc(@num);
@num = (9, 1, 7, 5, 3);
proc(@num);
@num = (1, 2, 4, 8, 16);
proc(@num);
@num = (5, -1, 3, 1, -3);
proc(@num);
@num = (1.5, 3, 0, 4.5, 6);
proc(@num);
