use v5.38;

sub is_square($n, @square) {
    for my $sq (@square) {
	return 1 if ($sq == $n);
    }
    return 0;
}

sub walk($p, $v, $h, @square) {
    my @path = @$p;
    my %visited = %$v;
    my %h = %$h;
    my $next = $path[$#path];
    if (scalar @path == -1 + scalar keys %h) {
	say "@path" if (is_square($path[0] + $path[$#path], @square));
	return;
    } else {
	$visited{$next} = 1;
	for my $node (@{$h{$next}}) {
	    unless ($visited{$node}) {
		my @P = @path;
		push @P, $node;
		walk(\@P, \%visited, \%h, @square);
	    }
	}
    }
}


sub traverse($h, @square) {
    my %h = %$h;		# square-candidates
    my @list = sort {$a <=> $b} keys %h;
    
    my $min = 3;
    for my $v (values %h) {
	my $val = scalar @$v;
	$min = $val if ($val < $min);
    }
    if ($min < 2) { # No possible cycle if an element only has one square-candidate
	say "Output: -1";
    } else {
	my @path = (1);
	my %visited;
	walk(\@path, \%visited, \%h, @square);
    }
   
}

sub proc($num) {
    say "Input: \$n = $num";
    my $upper_limit = int(sqrt(2*$num));
    my @square = map {$_*$_} (1 .. $upper_limit);
    shift @square;
    ## h{key} contains all square-pairs for key
    ## i.e. h{key} = 4 - key, 9 - key, 16 - key, etc.
    my %h;
    my @list = (1 .. $num);
    for my $l (@list) {
	my @L;
	for my $s (@square) {
	    next if ($s <= $l);
	    my $diff = $s - $l;
	    push @L, $diff unless ($diff > $num || $diff == $l);
	}
	$h{$l} = \@L;
    }

    traverse(\%h, @square);
    
}

my $n = 32;
proc($n);

$n = 15;
proc($n);

$n = 34;
proc($n);
