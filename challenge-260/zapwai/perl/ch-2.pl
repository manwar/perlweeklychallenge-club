use v5.36;

sub proc($word) {
    my %words;
    say "Input: $word";
    my @let = split "", $word;
    L(length $word, \@let, \%words);
    my @sorted = sort keys %words;
    say "Output: ", 1 + seek_word($word, @sorted);
}

sub L($k, $list, $r) {
    if ($k == 1) {
	$$r{join("",@$list)} = 1;
    } else {
	L($k-1, $list, $r);
	for my $i (0 .. $k-2) {
	    if ($k % 2 == 0) {
		swap($i, $k-1, $list);
	    } else {
		swap(0, $k-1, $list);
	    }
	    L($k-1, $list, $r);
	}
    }
}
    
sub swap($i, $j, $list) {
    my $hold = $$list[$i];
    $$list[$i] = $$list[$j];
    $$list[$j] = $hold;
}

sub seek_word ($word, @sorted) {
    for my $i (0 .. $#sorted) {
	return $i if ($sorted[$i] eq $word);
    }
    return -1;
}

proc("CAT");
proc("GOOGLE");
proc("SECRET");
