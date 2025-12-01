use v5.38;

use Algorithm::Permute;
use List::Util 'uniq', 'sum';

sub proc($from, $to, $count) {
    say "Input: \$from = $from, \$to = $to, \$count = $count";
    my $total_cnt = 0;
    for my $int ($from .. $to) {
	my $cnt = 0;
	my @perm;
	my @perms;		# contains duplicates
	my @l = split '', $int;
	my $p = Algorithm::Permute->new(\@l);
	while (my @p = $p->next) {
	    my $s = join '', @p;
	    push @perms, $s;
	}
	@perm = uniq @perms;

	# Remove integers in the permutation list with a leading zero
	my @bad_ind = grep {substr($perm[$_], 0, 1) eq '0'} (0 .. $#perm);
	splice @perm, $_, 1 for (reverse @bad_ind);

	# Find some witnesses
	for my $i (0 .. $#perm) {
	    my $num = $perm[$i];
	    next if ($num == $int);
	    if ($num % $int == 0 || $int % $num == 0) {
		$cnt++;
		say "$int ($num)";
	    }
	}
	if ($cnt >= $count) {
	    $total_cnt++;
	}
    }
    say "Output: $total_cnt";
}

my $from = 1;
my $to = 1000;
my $count = 1;
proc($from, $to, $count);

$from = 1500;
$to = 2500;
$count = 1;
proc($from, $to, $count);

# $from = 1_000_000; $to = 1_500_000; $count = 5;
# proc($from, $to, $count);

# $from = 13_427_000; $to = 14_100_000; $count = 2;
# proc($from, $to, $count);

$from = 1000; $to = 5000; $count = 1;
proc($from, $to, $count);

# (Naive approach)
