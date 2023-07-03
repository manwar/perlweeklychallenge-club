use v5.30;
my $str1 = "12345";
my $str2 = "112358";
my $str3 = "199100199";
my $str4 = "12364884132";
my $str5 = "28101828";
my $str6 = "7111829";
my $str7 = "112358132134";
my $str8 = "12345657910351614";
my $str9 = "102420483072";
my $str10 = "21425";
my $str11 = "3105108";
my @S = ($str1, $str2, $str3, $str4, $str5, $str6, $str7, $str8, $str9, $str10, $str11);
for my $i (0 .. $#S) {
    my $str = $S[$i];
    my $outstr = "Sorry, not additive.";
    say "Input: \$str = $str";
    print "Output: ";
    say chunk(\$outstr, $str);
    say $outstr;
    say "-" x 20;
}

sub chunk {
    my $r = shift;
    my $str = shift;
    my @pile_of_string = make_pile($str);
    for my $s (@pile_of_string) {
	my @nums = split " ", $s;
	return 1 if (check($r, @nums) == 1);
    }
    return 0;
}

sub make_pile {
    my $str = shift;
    my $n = length($str) - 1;
    my $l = '%0' . $n . 'b';    
    my @A;
    my @letters = split "", $str;
    my @mask;
    for (0 .. 2**$n - 1) {
	push @mask, sprintf $l, $_;
    }
    foreach my $mask (@mask) {
	my @bits = split "", $mask;
	my @list;
	for my $i (0 .. $#bits) {
	    push @list, $i if ($bits[$i] == 1);
	}
	my $newstr;
	foreach my $i (0 .. $#letters) {
	    $newstr .= $letters[$i];
	    $newstr .= " " if ($i ~~ @list);
	}
	push @A, $newstr;
	
    }
    return @A;
}

sub check {
    my $str_ref = shift;
    my @nums = @_;
    return 0 if (@nums == 2);
    my $cnt = 0;    
    for my $i (0 .. $#nums - 2) {
	$cnt++ if ($nums[$i] + $nums[$i + 1] == $nums[$i + 2]);
    }
    if ($cnt == $#nums - 1) {
	$$str_ref = "\t@nums is additive!";
	return 1;
    }
    return 0;
}

