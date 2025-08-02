use v5.38;
     
my $input = <<"ENDL";
/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e
ENDL

sub proc($input) {
    my @line = split("\n", $input);
    my $prefix = $line[0];
    my $cnt = 0;
    do {
	$cnt = 0;
	$prefix = substr $prefix, 0, rindex($prefix, "/");
	for my $i (0 .. $#line) {
	    if ($line[$i] !~ /^$prefix\//) {
		$cnt++;
	    }
	}
    } while($cnt > 0);
    return $prefix;
}

say proc($input);
