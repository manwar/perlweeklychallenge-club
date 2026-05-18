use v6;

sub all_vowels_check($word) {
    return ($word ~~ /a/ &&
	    $word ~~ /e/ &&
	    $word ~~ /i/ &&
	    $word ~~ /o/ &&
	    $word ~~ /u/).Bool;
}

# Return -1 if non-vowel
# Return 1 if five vowels
# Return 0 otherwise
sub finished($word) {
    if $word ~~ /<-[aeiou]>/ {
	return -1;
    } elsif all_vowels_check($word) {
	return 1;
    }
    return 0;
}

sub subvowel($a, @l) {
    my $word = @l[$a];
    my $flag = 0;
    for $a ..^ @l.end -> $i {
	if (finished($word) == 1) {
	    return $word;
	} elsif (finished($word) == -1) {
	    return "no";
	}
	if ($flag == 0) {
	    if (@l[$i+1] eq @l[$a]) {
		return "no";
	    } else {
		$word ~= @l[$i+1];
		$flag = 1;
		next;
	    }
	}
	$word ~= @l[$i+1];
    }
    if finished($word) == 1 {
	return $word;
    } else {
	return "no";
    }
}

sub proc($s) {
    say "Input: $s";
    my @l = $s.comb;
    my @list;
    for 0 .. @l.end - 4 -> $i {
	my $word = subvowel($i, @l);
	push @list, $word if $word ne "no";
    }
    say "Output: " ~ @list;
}

my $s = "aeiou";
proc($s);
$s = "aaeeeiioouu";
proc($s);
$s = "aeiouuaxaeiou";
proc($s);
$s = "uaeiou";
proc($s);
$s = "aeioaeioa";
proc($s);
