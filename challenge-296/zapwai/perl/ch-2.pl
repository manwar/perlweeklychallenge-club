use v5.38;
use List::Util qw( sum );

sub sqsides($side_length, $sides_left, %h) {
    my @nums;
    for (sort keys %h) {
	next if ($_ == $side_length);
	for my $i (1 .. $h{$_}) {
	    push @nums, $_;
	}
    }
    my $cnt = 0;
    my @taken;
    my $index = 0;
    do {
	push @taken, splice @nums, $index, 1;
	my $tally = sum(@taken);
	if ($tally == $side_length) {
	    $cnt++;
	    $index = 0;
	    @taken = ();
	} elsif ($tally > $side_length) {
	    unshift @nums, @taken;
	    @taken = ();
	    $index++;
	}
	
    } while ($index <= $#nums);
    
    return 1 if ($cnt == $sides_left);
    return 0;
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $sum = sum(@ints);
    my $ans = "not";
    if ($sum % 4 == 0) {	# Perimeter is divisible by four
	my $side_length = $sum / 4;
	my %h;
	$h{$_}++ for (@ints);
	my $sides_left = 4;
	$sides_left -= $h{$side_length} // 0; # sides unaccounted for
	my $remaining_sum = 0;
	for (sort keys %h) {
	    if ($_ != $side_length) {
		$remaining_sum += $_ * $h{$_};
	    }
	}
	if (($remaining_sum / $sides_left) == $side_length) {
	    $ans = "is" if (sqsides($side_length, $sides_left, %h));
	}
	say "\t(Side length $side_length)";
    } 
    say "Output: Square $ans possible.";
}

my @ints = (1, 2, 2, 2, 1);
proc(@ints);
@ints = (2, 2, 2, 4);
proc(@ints);
@ints = (2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
proc(@ints);
@ints = (3, 1, 2, 4, 2, 4);
proc(@ints);
@ints = (3, 3, 4, 2, 4);
proc(@ints);
@ints = (3, 3, 2, 2, 2, 6, 6);
proc(@ints);
@ints = (3, 4, 1, 4, 3, 1);
proc(@ints);
