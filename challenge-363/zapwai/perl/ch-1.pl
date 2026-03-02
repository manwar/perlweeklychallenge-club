use v5.38;

my @D = qw( zero one two three four five six seven eight nine ten );
my @V = qw( a e i o u );

sub proc($str) {
    say "Input: \$str = $str";
    my @word = split ' ', $str;
    my $word = $word[0];
    my ($vow_cnt, $con_cnt) = (0,0); # claimed count, in english
    for my $i (0 .. $#word) {
	if ($word[$i] =~ /vowel/) {
	    $vow_cnt = $word[$i-1];
	} elsif ($word[$i] =~ /consonant/) {
	    $con_cnt = $word[$i-1];
	}
    }
    my ($vow_ind, $con_ind) = (-1, -1); # claimed count, in numeric
    for my $i (0 .. $#D) {
	if ($D[$i] eq $vow_cnt) {
	    $vow_ind = $i;
	}
	if ($D[$i] eq $con_cnt) {
	    $con_ind = $i;
	}
    }
    my @letter = split '', $word;
    my ($vowel_count, $con_count) = (0, 0); # the actual count
    for my $l (@letter) {
	my $is_vowel = 0;
	for my $v (@V) {
	    if ($l eq $v) {
		$vowel_count++;
		$is_vowel = 1;
		last;
	    }
	}
	if ($is_vowel == 0) {
	    $con_count++;
	}
    }
    say "Output: ", ($vow_ind == $vowel_count && $con_ind == $con_count) ? "true" : "false";
    
}

my $str = "aa — two vowels and zero consonants";
proc($str);
$str = "iv — one vowel and one consonant";
proc($str);
$str = "hello — two vowels and three consonants";
proc($str);
$str = "aeiou — five vowels and zero consonants";
proc($str);
$str = "aei — three vowels and zero consonants";
proc($str);
