use v6;

# change k letters, at random, into $letter
sub swap(@c, $letter, @l) {
    for @c -> $i {
	splice @l, $i, 1, $letter;
    }
    return @l.join('');
}

sub cont_len($word) {
    my @len;
    my @l = $word.comb;
    my $len = 1;
    my $flag = 0;
    for 0 .. @l.end - 1 -> $i {
	if @l[$i] eq @l[$i+1] {
	    $flag = 1;
	    $len++;
	} else {
	    @len.push($len);
	    $len = 1;
	    $flag = 0;
	}
    }
    @len.push($len);
    return @len.max;
}

sub proc($s, $k) {
    say "Input: \$str = $s, \$k = $k";
    my @L = $s.comb;
    my @D = @L.unique;
    my @a = 0 .. @L.end;
    my @C = @a.combinations: $k;
    my $len = 0;
    for @D -> $letter {
	for @C -> $comb {
	    my @l = @L;
	    my $clen = cont_len(swap($comb, $letter, @l));
	    $len = $clen if $len < $clen;
	}
    }
    say "Output: $len";
}

my $str = "AAAAA"; my $k = 2;
proc($str, $k);
$str = "ABCDE"; $k = 4;
proc($str, $k);
$str = "AAABBBBAA"; $k = 1;
proc($str, $k);
$str = "ABACADA"; $k = 2;
proc($str, $k);
$str = "BAAABAAAA"; $k = 1;
proc($str, $k);
