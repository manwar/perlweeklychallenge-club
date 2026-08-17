use v5.38;

sub parse(@chunk) {
    my %h;
    for my $c (@chunk) {
	my @char = split '', $c;
	my $mult_flag = 0;	# tracks multi-digit multipliers
	my $atom = $char[0];
	my $mult = 1;
	for my $i (1 .. $#char) {
	    my $char = $char[$i];
	    if ($char =~ /[a-z]/) {
		$atom .= $char;
		next;
	    } elsif ($char =~ /\d/) {
		if ($mult_flag == 1) {
		    $mult .= $char;
		} else {
		    $mult = $char;
		    $mult_flag = 1;
		}
		next;
	    } else {		# new atom
		$h{$atom} += $mult;
		$atom = $char;
		$mult = 1;
		$mult_flag = 0;
	    }
	}
	$h{$atom} += $mult;
    }
    return \%h;
}

sub proc($f) {
    say "Input: $f";
    while ($f =~ s/\(([^()]*)\)(\d+)/$1 x $2/e) {}

    ## ## Original Approach
    ## ## Had bugs on nested examples
    # my $o = $f;
    # my @chunk;
    # my $ind = index $o, "\(";
    # if ($ind == -1) {		# e.g. H203Mg4
    # 	push @chunk, $o;
    # } elsif ($ind != 0) {
    # 	my $b = substr $o, 0, $ind;
    # 	push @chunk, $b;
    # 	$o = substr $o, $ind;
    # }
    # if ($o =~ /\)\d+(\w+)$/) {
    # 	my $post = $1;
    # 	push @chunk, $post;
    # 	$o = substr $o, 0, -length($post);
    # }
    # my $nest_factor = 1;
    # while ($o =~ /\(/) {
    # 	# if nested, extra multiplier
    # 	if ($o =~ /^\(\(/) {
    # 	    $o =~ /\)(\d+)$/;
    # 	    $nest_factor = $1;
    # 	}

    # 	$o =~ /\((\w+)\)(\d+)/;
    # 	my $mol = $1;
    # 	my $mult = $2 * $nest_factor;
    # 	say "$mol x$mult";
    # 	my $ind = index $o, "\)";
    # 	#say "Index of next paren: $ind";
    # 	my $s = $mol x $mult;# . substr $o, $ind + 2;
    # 	push @chunk, $s;
    # 	$o = substr $o, $ind + length($mult);
    # }
    # my $hashref = parse(@chunk);
    ## ##
    
    my $hashref = parse($f);
    my %h = %$hashref;
    my $output = "";
    for my $key (sort keys %h) {
	$output .= "$key$h{$key}";
    }
    say "Output: $output";
}
my $f = "((N2O)3(H2O)2)2";
proc($f);
$f = "Mg3(PO4)2";
proc($f);
$f = "(((H)2)3)4";
proc($f);
$f = "NaCl3(O2(S10)2)2Mg";
proc($f);
$f = "Z2Y3(X2W)2";
proc($f);
