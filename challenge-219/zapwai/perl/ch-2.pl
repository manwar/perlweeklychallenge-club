use v5.30.0;
no warnings;
use Algorithm::Permute;
# Minimizes cost by checking every permutation of day/week/month passes.
#my @costs = (5, 30, 90);
#my @days = (1, 3, 4, 5, 6, 30);
#my @days = (1, 5, 6, 7, 9, 15);
my @days = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31);
my @costs = (2, 7, 25);

@days = sort {$a <=> $b} @days;
say "Input:  \@costs = (" . join(",",@costs) .")";
say "\t\@days = (" . join(",",@days).")";
my $range = 1 + $days[$#days] - $days[0];

my $max_weeks = $range / 7;
my $max_months = $range / 30;
$max_weeks++ if ($range % 7 > 0);
$max_months++ if ($range % 30 > 0);

my $min = 10*($costs[0] + $costs[1] + $costs[2]);
my ($D, $W, $M);
for my $k (0 .. $max_months) {    
    for my $j (0 .. $max_weeks) {
	for my $i (0 .. 6) {
	    if (covers($i, $j, $k)) {
		my $cost = cost($i, $j, $k);
		if ($cost < $min) {
		    $min = $cost;
		    ($D, $W, $M) = ($i, $j, $k);		
		}
	    }
	}
    }
}
say "Output: \$$min using $D days, $W weeks, and $M months.";

# Return true if days array can be covered by the given # of cards.
sub covers {
    my ($d, $w, $m) = @_;
    return 0 if (($d == 0) && ($w == 0) && ($m == 0));
    return 1 if (($range <= 30) && ($m > 0));
    return 1 if ($#days < $d + $w + $m);
    if (($w == 0) && ($m == 0)) {
	return 0 unless ($d > $#days);
    }
    my @tickets = ('d') x $d;
    push @tickets,('w') x $w;
    push @tickets,('m') x $m;

    my $p = Algorithm::Permute->new(\@tickets);
    my @processed;	   # Skip permutations we've already processed
    while (my @perm = $p->next) {
	my $str = join("",@perm);
	if ($str ~~ @processed) {
	    next ;
	} else {
	    push @processed, $str;
	}
	my @sched = @days;
	foreach my $char (@perm) {
	    given ($char){
		when('d'){ shift @sched; }
		when('w'){ bite_sched(\@sched, 6); }
		when('m'){ bite_sched(\@sched, 29); }		
	    }
	    return 1 unless (@sched);
	}
    }
    0
}

sub bite_sched {
    my ($ref, $size) = @_;
    my $end_day = $$ref[0] + $size;
    my $cnt = 0;
    foreach (@$ref) {
	$cnt++ if ($_ <= $end_day);
    }
    while ($cnt) {
	shift @$ref;
	$cnt--;
    }    
}

sub cost {
    my ($d, $w, $m) = @_;
    return $d*$costs[0] + $w*$costs[1] + $m*$costs[2];
}
