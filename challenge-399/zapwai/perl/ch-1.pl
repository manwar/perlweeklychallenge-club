use v5.38;
use List::Util "uniq", "max";

sub comb($r, @a) {
    return [] if ($r > @a);
    return [[]] if ($r == 0);
    return [] if @a == 0;
    my $f = shift @a;
    #include first
    my $with = comb($r - 1, @a);
    my @with_first = map { [$f, @$_] } @$with;
    #exclude first
    my $without = comb($r, @a);
    return [@with_first, @$without];
}

# change k letters, at random, into $letter
sub swap($cref, $letter, @l) {
    for my $i (@$cref) {
	splice @l, $i, 1, $letter;
    }
    return join '', @l;
}

sub cont_len($word) {
    my @len;
    my @l = split '', $word;
    my $len = 1;
    my $flag = 0;
    for my $i (0 .. $#l - 1) {
	if ($l[$i] eq $l[$i+1]) {
	    unless ($flag) {
		$flag = 1;
	    }
	    $len++;
	} else {
	    push @len, $len;
	    $len = 1;
	    $flag = 0;
	}
    }
    push @len, $len;
    return max(@len);
}

sub proc($s, $k) {
    say "Input: \$str = $s, \$k = $k";
    my @L = split '', $s;
    my @D = uniq(@L);
    my @a = (0 .. $#L);
    my $C = comb($k, @a);
    my $len = 0;
    for my $letter (@D) {
	for my $comb (@$C) {
	    my $clen = cont_len(swap($comb, $letter, @L));
	    $len = $clen if ($len < $clen);
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
