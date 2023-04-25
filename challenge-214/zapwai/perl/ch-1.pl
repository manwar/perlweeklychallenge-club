use v5.30.0;
my @scores = (1,2,4,3,5);

my @copy = @scores;
my %vals;

$vals{$_} = 1 foreach (@scores);

my @ordered_vals = keys %vals;
@ordered_vals = reverse sort @ordered_vals;
my @ranks;
for my $k (0 .. $#scores) {
    foreach my $j (0 .. $#ordered_vals) {
	$ranks[$k] = $j + 1 if ($scores[$k] == $ordered_vals[$j]);
    }
}
    
my ($one, $two, $tre);
foreach (0 .. $#ranks) {
    if ($ranks[$_] == 1) {
	$one++;
    } elsif ($ranks[$_] == 2) {
	$two++;
    } elsif ($ranks[$_] == 3) {
	$tre++;
    }
}

if ($one > 3) {
    # Assign only gold
    foreach (0 .. $#ranks) {
	if ($ranks[$_] == 1) {
	    $ranks[$_] = "G";
	}
    }    
} elsif ( $one + $two  >= 3 ) {
    # assign gold and silver
    foreach (0 .. $#ranks) {
	if ($ranks[$_] == 1) {
	    $ranks[$_] = "G";
	} elsif ($ranks[$_] == 2) {
	    $ranks[$_] = "S";
	}
    }    
} else {
    foreach (0 .. $#ranks) {
	if ($ranks[$_] == 1) {
	    $ranks[$_] = "G";
	} elsif ($ranks[$_] == 2) {
	    $ranks[$_] = "S";
	} elsif ($ranks[$_] == 3) {
	    $ranks[$_] = "B";
	}
    }    
    
}

print "\@scores: ";
print foreach (@scores);
say "";

print "\@ranks : ";
print foreach (@ranks);
say "";
