use v5.38;

# Only tests values 0 through 9 (larger would require a rewrite)
# Returns an array of refs to arrays with these values.
sub setup($n) {
    my @o;
    for my $i (0 .. 10**$n - 1) {
	my $lab = "%0$n"."d";
	my @a = split "", sprintf($lab, $i);
	push @o, \@a;
    }
    return @o;
}

sub enc($init, @enc) {
    my @orig = ($init);
    my @list = setup(scalar @enc);
    push @orig, @{$list[0]};
    my $err = 0;
    my $lvl = 0;
    do {
	$err = 0;
	my @current;
	for my $i (0 .. $#orig - 1) {
	    push @current, $orig[$i] ^ $orig[$i+1];
	}
	say "@orig -> @current";
	for my $i (0 .. $#enc) {
	    if ($enc[$i] != $current[$i]) {
		$err = 1;
		$lvl++;
		last;
	    }
	}
	unless ($err == 0) {
	    @orig = ($init);
	    push @orig, @{$list[$lvl]};
	}
    } while ($err > 0);
    return @orig;
}

sub proc($init, @enc) {
    say "Input: \@encoded = @enc, \$initial = $init";
    say "Output: ", enc($init, @enc);
}

my $init = 1;
my @enc = (1, 2, 3);
proc($init, @enc);

$init = 4;
@enc = (6,2,7,3);
proc($init, @enc);

