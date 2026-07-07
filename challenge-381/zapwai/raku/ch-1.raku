use v6;

sub check_row(@m){
    if @m.elems == 1 {
	return True if @m[0] == 1;
    }
    my $cnt = 0;
    for @m -> @row {
	J: for 1 .. @m.elems -> $j {
	    for @row -> $val {
		if $val == $j {
		    $cnt++;
		    next J;
		}
	    }
	}
    }
    return $cnt == @m.elems*@m.elems;
}

sub check_col(@m) {
    my @n = [Z] @m;
    return check_row(@n);
}

sub proc(@m) {
    say "Input: \@matrix = ", @m;
    say "Output: ", check_row(@m) && check_col(@m) ??
			     "true" !! "false";
}

my @m = ([1, 2, 3, 4],
	 [2, 3, 4, 1],
	 [3, 4, 1, 2],
	 [4, 1, 2, 3],);
proc(@m);

@m = ([1]); 
proc(@m);

@m = ([1, 2, 5],
      [5, 1, 2],
      [2, 5, 1],);
proc(@m);

@m = ([1, 2, 3],
      [1, 2, 3],
      [1, 2, 3],);
proc(@m);
@m = ([1, 2, 3],
      [3, 1, 2],
      [3, 2, 1],);
proc(@m);
