use v5.30.0;
# There are 2^(m+n) variations to check.
my @matrix = ( [0,0,1,1],[1,0,1,0],[1,1,0,0] );
#my @matrix = ( [0] );
my $m = $#matrix;
my $n = $#{$matrix[0]};

print "Input: \@matrix = ";
printit();

my $max;
my @ans;   # (in binary) the maximal solution
# A 3x4 matrix will have its toggles encoded by rrrcccc
# e.g. 1100100 -> first two rows and second column toggled.
for ( 0 .. 2**($m+$n+2) - 1 ) {
    my $sum = $m + $n;
    my $key = sprintf "%0$sum".'b', $_;
    my @key = split("",$key);
    
    my $r = fresh_copy();
    my @new = @$r;

    proc_key(\@new,@key);
    my $score = score(\@new,0);

    if ($max < $score) {
	@ans = @key;
	$max = $score;
    }
}

print "  "; printkey(\@ans, $m);
print "  Resulting matrix: ";
proc_key(\@matrix,@ans);
printit();
print "  "; score(\@matrix,1);
say "Output: $max";

sub fresh_copy {
    my @new;
    foreach my $row (@matrix) {
	my @M = @$row;
	my @N;
	foreach (@M) {
	    push @N, $_;
	}
	my $ref = \@N;
	push @new, $ref;
    }
    return \@new;
}

sub proc_key {
    my ($ref, @key) = @_;
    for my $i (0 .. $#key) {
	if ($i <= $m) {
	    toggle($ref, 'r', $i) if ($key[$i]);
	} else {
	    toggle($ref, 'c', ($i - $m - 1)) if ($key[$i]);
	}
    }
}

sub printkey {
    my ($ref,$m) = @_;
    my @key = @$ref;
    my $str;
    for my $i (0 .. $#key) {
	if ($i <= $m) {
	    $str .= "row " . ($i+1) . " " if ($key[$i]);
	} else {
	    $str .= "col " . ($i - $m) . " " if ($key[$i]);
	}
    }
    say "Toggle: $str";
}

sub score {
    my ($ref,$flag) = @_;
    my @m = @$ref;
    my $sum;
    my ($binstr,$decstr);
    foreach my $i (0 .. $#m) {
	my $num = join("",@{$m[$i]});
	$binstr .= "0b$num + ";
	$decstr .= eval("0b$num") . " + ";
	$sum += eval("0b$num");
    }
    $_ = substr $_, 0, -3 for ($binstr, $decstr);
    say "$binstr -> $decstr = $sum" if ($flag);
    return $sum;
}

sub printit {
    print "(";
    for (0 .. $#matrix) {
	print '[' . join(",",@{$matrix[$_]}) . "]";
	print ", " unless ($_ == $#matrix);
    }
    say ")";
}

sub toggle {
    my ($ref, $char, $index) = @_;
    my @m = @$ref;
    if ($char eq 'c') {
	for (0 .. $#m) {
	    if (${$m[$_]}[$index] == 1) {
		${$m[$_]}[$index] = 0;
	    } else {
		${$m[$_]}[$index] = 1;
	    }
	}
    } else {
	for (0 .. $#{$m[$index]}) {
	    if (${$m[$index]}[$_] == 1) {
		${$m[$index]}[$_] = 0;
	    } else {
		${$m[$index]}[$_] = 1;
	    }
	}
    }
}
