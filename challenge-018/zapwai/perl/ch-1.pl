use v5.38;
if (@ARGV < 2) {
    say "Please provide two (or more) arguments.";
    exit;
}

sub gen_substr($word) {
    my @subs;
    my $current_length = 1;
    my $a = -1;
    do {
	$a++;
	if ($a + $current_length > length $word) {
	    $a = 0;
	    $current_length++;
	}
	push @subs, substr($word, $a, $current_length);
    } while ($current_length < length $word);
    return @subs;
}

sub common(@list) {
    my $ans;
    my @subs;
    for my $i (0 .. $#list) {
	push @subs, gen_substr($list[$i]);
    }
    my @common;
    for my $i (0 .. $#subs) {
	for my $j (0 .. $#subs) {
	    next if ($i == $j);
	    push @common, $subs[$i] if ($subs[$i] eq $subs[$j]);
	}
    }
    my $max = 0;
    my $ans_word;
    for my $word (@common) {
	if (length $word > $max) {
	    $max = length $word;
	    $ans_word = $word;
	}
    }
    return $ans_word;
}

say common(@ARGV);
