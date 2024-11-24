use v5.38;
use List::Util qw( sum );

sub copout($side_length, $sides_left, %supply) {
    # This function is incorrect but I'll use it for emergencies.
    # Useful for weird cases where number of plausible moves is very large.
    my @nums;
    for (sort keys %supply) {
	next if ($_ == $side_length);
	for my $i (1 .. $supply{$_}) {
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

sub sqsides($side_length, $sides_left, %supply) {
    my @nums;
    for (sort keys %supply) {
	next if ($_ == $side_length);
	for my $i (1 .. $supply{$_}) {
	    push @nums, $_;
	}
    }
    my @moves;
    for my $i (1 .. 2**@nums - 1) {
	my $n = @nums;
	my $set = '%0'.$n.'b';
	my $x = sprintf($set, $i);
	my @d = split('', $x);
	my @n;
	for (0 .. $#nums) {
	    push @n, $nums[$_] if ($d[$_] == 1);
	}
	my $tot = sum(@n);
	push @moves, \@n if ($tot == $side_length);
    }

    if (@moves > 20) {
	return 1 if copout($side_length, $sides_left, %supply);
    } else {
	unless (@moves == 0) {
	    for my $i (1 .. 2**@moves - 1) {
		my $n = @moves;
		my $set = '%0'.$n.'b';
		my $x = sprintf($set, $i);
		my @d = split('', $x);
		my $tally = sum(@d);
		next if ($tally != $sides_left);
		my @n;
		for my $i (0 .. $#moves) {
		    push @n, @{$moves[$i]} if ($d[$i] == 1);
		}
		my %demand;
		$demand{$_}++ for (@n);
		my $cnt = 0;
		for my $key (sort keys %demand) {
		    $cnt++ if ($demand{$key} <= $supply{$key});
		}
		return 1 if ($cnt == scalar keys %demand);
	    }
	}
    }
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
    say "Output: Square $ans possible.\n";
}

my @ints = (1, 2, 2, 2, 1);
proc(@ints);
@ints = (2, 2, 2, 4);
proc(@ints);
@ints = (3, 1, 2, 4, 2, 4);
proc(@ints);
@ints = (3, 3, 4, 2, 4);
proc(@ints);
@ints = (3, 3, 2, 2, 2, 6, 6);
proc(@ints);
@ints = (3, 4, 1, 4, 3, 1);
proc(@ints);
# Thanks to Jörg Sommrey for testing :-)
@ints = (571, 362, 67, 413, 215, 372, 16, 457, 527, 1000);
proc(@ints);
@ints = (2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
proc(@ints);
