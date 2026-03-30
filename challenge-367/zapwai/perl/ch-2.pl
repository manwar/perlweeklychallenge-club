use v5.38;

# Return -1 if $a < $b, 0 if equal, 1 otherwise
sub timecmp($a, $b) {
    my ($hr1, $min1) = split ':', $a;
    my ($hr2, $min2) = split ':', $b;
    return 0 if ($hr1 == $hr2 && $min1 == $min2);
    # Midnight condition
    my $t1 = 60*$hr1 + $min1;
    my $t2 = 60*$hr2 + $min2;
    if (abs($t2 - $t1) > 12*60) {
	if ($t2 < $t1) {
	    $hr2 += 24;
	} else {
	    $hr1 += 24;
	}
    }
    if ($hr1 < $hr2) {
	return -1;
    } elsif ($hr1 == $hr2) {
	if ($min1 < $min2) {
	    return -1;
	} else {
	    return 1;
	}
    } else {
	return 1;
    }
}

# Return 1 if there is a conflict.
sub conflict($e1, $e2) {
    my @e1 = @$e1;
    my @e2 = @$e2;
    if (timecmp($e1[0], $e2[0]) < 1) { # Normal ordering (e1 before e2)
	if (timecmp($e1[1], $e2[0]) < 1) {
	    return 0;
	} else {
	    return 1;
	}
    } else {			# event 2 starts before event 1
	if (timecmp($e2[1], $e1[0]) < 1) {
	    return 0;
	} else {
	    return 1;
	}
    }
}

sub proc($e1, $e2) {
    say "Input:  \@event1 = (@$e1)\n\t\@event2 = (@$e2)";
    say "Output: " , conflict($e1, $e2) ? "true" : "false";
}

my @event1 = ("10:00", "12:00");
my @event2 = ("11:00", "13:00");
proc(\@event1, \@event2);
@event1 = ("09:00", "10:30");
@event2 = ("10:30", "12:00");
proc(\@event1, \@event2);
@event1 = ("14:00", "15:30");
@event2 = ("14:30", "16:00");
proc(\@event1, \@event2);
@event1 = ("08:00", "09:00");
@event2 = ("09:01", "10:00");
proc(\@event1, \@event2);
@event1 = ("23:30", "00:30");
@event2 = ("00:00", "01:00");
proc(\@event1, \@event2);
