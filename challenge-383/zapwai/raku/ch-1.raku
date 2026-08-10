use v6;

sub contains($target, @list) {
    for @list -> $word {
	return 1 if $target eq $word;
    }
    return 0;
}

sub swap(@l2, @l3) {
    my @M;	  #contains all substitutions for each word of $list2 
    
    for 0 .. @l2.end -> $i {
	my $word = @l2[$i];
	push @M[$i], $word;
	# If word is in list3, push all variants into M
	for @l3 -> @L {
	    if contains($word, @L) == 1 {
		push @M[$i], |@L;
	    }
	}
    }

    for 0 .. @M.end -> $i {
	@M[$i] = @M[$i].unique;
    }

    my @list;
    push @list, $_.join(' ') for [X] @M;
    
    return @list;
}

sub proc(@l1, @l2, @l3) {
    print "Input: \$list1 = ", @l1, "\n \$list2 = ", @l2, "\n \$list3: ";
    print @$_,"; " for @l3;
    print "\n";
    my $o = "false";
    if @l3 == 0 {
	$o = "true";
    } else {
	my $target = join " ", @l1;
	my @L = swap(@l2, @l3);
	for @L -> $l {
	    $o = "true" if $l eq $target;
	}
    }

    say "Output: $o";
}

my @list1 = ("great", "acting");
my @list2 = ("fine", "drama");
my @list3 = (("great", "fine"), ("acting", "drama"));
proc(@list1, @list2, @list3);

@list1 = ("enjoy", "challenge");
@list2 = ("love", "weekly", "challenge");
@list3 = (("enjoy", "love"), ());
proc(@list1, @list2, @list3);
