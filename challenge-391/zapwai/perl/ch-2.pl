use v5.38;

sub follow($key, %h) {
    my @chains;
    return [ $key ] if (!exists $h{$key});

    for my $next (split ' ', $h{$key}) {
	my @subchains = follow($next, %h);

	for my $subchain (@subchains) {
	    push @chains, [ $key, @$subchain ];
	}
    }

    return @chains;
}

sub proc(@boxes) {
    print "Input: \@boxes = ";
    print "[".join(",", @$_)."] " for (@boxes);
    say "";
    my @width;
    my @height;
    for my $b (@boxes) {
	my @box = @$b;
	push @width, $box[0];
	push @height, $box[1];
    }
    my %h;
    for my $i (0 .. $#width) {
	my $str = "[$width[$i],$height[$i]]";
	for my $j (0 .. $#width) {
	    next if ($j == $i);
	    if ($width[$j] > $width[$i] &&
		$height[$j] > $height[$i]) {
		my $str2 = "[$width[$j],$height[$j]]";
		$h{$str} .= "$str2 ";
	    }
	}
    }

    my $max = 0;
    my @max_chain;
    for my $key (keys %h) {
	my @chains = follow($key, %h);
	for my $chain (@chains) {
	    my @curr_chain = @$chain;
	    my $length = scalar @curr_chain;
	    if ($length > $max) {
		$max = $length;
		@max_chain = @curr_chain;
	    }
	}
    }
    print "Output: $max \n\t";
    say "@max_chain";
    
}

my @boxes = ([1, 3], [3, 5], [6, 8], [2, 4]);
proc(@boxes);
@boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]);
proc(@boxes);
@boxes = ([5, 5], [5, 5], [5, 5]);
proc(@boxes);
@boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]);
proc(@boxes);
@boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]);
proc(@boxes);
