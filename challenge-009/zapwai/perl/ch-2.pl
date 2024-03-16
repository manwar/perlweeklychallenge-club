use v5.38;
my @list1 = (1, 2, 2, 3);
my @list2 = (1, 4, 6, 6, 8, 10, 10);
my @list3 = (1, 2, 2, 4, 4, 4, 5, 7, 9, 11, 11, 11);
my @list4 = (3, 3, 6, 6);
proc($_) foreach (\@list1, \@list2, \@list3, \@list4);

sub proc($ref) {
    say "Input: (", join(", ", @$ref), ")";
    my %rank;
    my $cnt;
    $rank{$_} = ++$cnt foreach (sort { $a <=> $b } @$ref);
    my @ranks;
    push @ranks, $rank{$_} for (sort {$a <=> $b} keys %rank);
    say "Stand: (", join(", ", standard(\@ranks)), ")";
    say "Modif: (", join(", ", modified(\@ranks)), ")";
    say "Dense: (", join(", ", dense(\@ranks)), ")\n";
}

sub modified($ref) {
    my $skipflag = $$ref[0];
    my @a;
    for (0 .. $#{$ref}) {
	push @a, ($$ref[$_]) x $skipflag;
	$skipflag = $$ref[$_ + 1] - $$ref[$_] if ($_ != $#{$ref});
    }
    @a
}

sub standard($ref) {
    my @b = modified($ref);
    my @a;
    my $repeat_flag = 0;
    my $repeat_lvl = 1;
    for (0 .. $#b) {
	$repeat_lvl = $repeat_flag ? $repeat_lvl : $_ + 1;
	$repeat_flag = 1 if ($_ != $#b)&&($b[$_ + 1] - $b[$_] == 0);
	push @a, $repeat_flag ? $repeat_lvl : $b[$_];
	$repeat_flag = 0 if ($_ != $#b)&&($b[$_ + 1] - $b[$_] != 0);
    }
    @a
}

sub dense($ref) {
    my @b = standard($ref);
    my @a;
    my $lvl = 1;
    my $catch = 0;
    for (0 .. $#b) {
	if ($b[$_] == $lvl) {
	    push @a, $b[$_];
	} elsif ($b[$_] == $catch) {
	    push @a, $lvl;
	} elsif ($b[$_] == $lvl + 1) {
	    $lvl++;
	    push @a, $b[$_];
	} else {
	    $catch = $b[$_];
	    $lvl++;
	    push @a, $lvl;
	}
    }
    @a
}

