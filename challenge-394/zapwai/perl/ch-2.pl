use v5.38;

# Does the given substring alternate vowels/consonants?
sub does_alt($s) {
    my $cons = "bcdfghjklmnpqrstvwxyz";
    my $vows = "aeiou";
    my @c = split '', $s;
    my $con_flag = ($cons =~ /$c[0]/);
    if ($con_flag == 1) {
	for my $i (1 .. $#c) {
	    return 0 if ($i % 2 == 1 && $cons =~ /$c[$i]/);
	    return 0 if ($i % 2 == 0 && $vows =~ /$c[$i]/);
	}
    } else {
	for my $i (1 .. $#c) {
	    return 0 if ($i % 2 == 1 && $vows =~ /$c[$i]/);
	    return 0 if ($i % 2 == 0 && $cons =~ /$c[$i]/);
	}
    }
    return 1;
}

sub proc(@str) {
    say "Input: @str";
    my @out;
    my @int;			# potential intersections
    my $len = length($str[0]);
    # i is starting index, lengths will vary from 2 to len - index
    my $sublen = 1;
    while ($sublen <= $len) {
	$sublen++;
	for my $i (0 .. $len - $sublen) {
	    my $substr = substr $str[0], $i, $sublen;
	    next unless (does_alt($substr) == 1);
	    push @int, $substr if ($str[1] =~ /$substr/ && $str[2] =~ /$substr/);
	}
    }
    push @out, $int[$#int] if ($int[$#int]);
    for my $i (0 .. $#int - 1) {
	my $word = $int[$i];
	my $flag = 0;
	for my $j ($i + 1 .. $#int) {
	    my $word2 = $int[$j];
	    $flag = 1 if ($word2 =~ /$word/);
	}
	push @out, $word unless ($flag);
    }
    say "Output: @out";
}

my @str = ("relocate", "delocate", "allocate");
proc(@str);
@str = ("apple", "banana", "cherry");
proc(@str);
@str = ("navigate", "cavity", "gravity");
proc(@str);
@str = ("pedalgia", "pedalboard", "pedantic");
proc(@str);
@str = ("schoolmaster", "schoolhouse", "schooling");
proc(@str);
