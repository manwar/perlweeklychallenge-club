use v5.38;

## Decided not to use partial matches
##
# my @hours = (0 .. 23);
# my @mins = (0 .. 59);
# for my $i (0 .. 9) {
#     $hours[$i] = "0".$hours[$i];
#     $mins[$i] = "0".$mins[$i];
# }

sub fithour($t) {
    my @t = split '', $t;
    if ($t[0] eq '?' && $t[1] eq '?') {
	return 24;
    } elsif ($t[0] eq '?') {
	if ($t[1] > 3) {
	    return 2;
	} else {
	    return 3;
	}
    } else {
	if ($t[0] == 2) {
	    return 4;
	} else {
	    return 10;
	}
    }
}

sub fitmin($t) {
    my @t = split '', $t;
    if ($t[0] eq '?' && $t[1] eq '?') {
	return 60;
    } elsif ($t[0] eq '?') {
	return 6;
    } else {
	return 10;
    }
}

sub proc($s) {
    say "Input: \$time = $s";
    my ($hr, $min) = split ':', $s;
    my $tot1 = 1;
    if ($hr =~ /\?/) {
	$tot1 = fithour($hr);
    }
    my $tot2 = 1;
    if ($min =~ /\?/) {
	$tot2 = fitmin($min);
    }
    my $total =$tot1 * $tot2;
    say "Output: $total";
}

my $time = "?2:34";
proc($time);

$time = "?4:?0";
proc($time);

$time = "??:??";
proc($time);

$time = "?3:45";
proc($time);

$time = "2?:15";
proc($time);
