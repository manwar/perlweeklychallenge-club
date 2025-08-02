use v5.38;
my @source  = (0, 1, 2, 3, 4);
my @indices = (0, 1, 2, 2, 1);
proc(\@source, \@indices);

@source  = (1, 2, 3, 4, 0);
@indices = (0, 1, 2, 3, 0);
proc(\@source, \@indices);

@source = (1);
@indices = (0);
proc(\@source, \@indices);

sub proc($s, $i) {
    my @source = @$s;
    my @indices = @$i;
    say "Input: \@source = @source, \@indices = @indices";
    my @target;
    for my $i (0 .. $#source) {
	my @chunk = splice @target, $indices[$i];
	$target[$indices[$i]] = $source[$i];
	push @target, @chunk;
    }
    say "Output: @target";
}
