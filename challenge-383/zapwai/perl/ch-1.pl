use v5.38;

use List::Util "uniq";

sub contains($target, @list) {
    foreach my $word (@list) {
	if ($target eq $word) {
	    return 1;
	}
    }
    return 0;
}

sub swap($l2, $l3) {
    my @M;	  #contains all substitutions for each word of $list2 
    
    for my $i (0 .. $#$l2) {
	my $word = $$l2[$i];
	push @{$M[$i]}, $word;
	# If word is in list3, push all variants into M
	foreach my $aref (@$l3) {
	    my @L = @$aref;
	    if (contains($word, @L)) {
		push @{$M[$i]}, @L;
	    }
	}
    }

    for my $i (0 .. $#M) {
	@{$M[$i]} = uniq @{$M[$i]};
    }

    my @list = @{$M[0]};
    for my $i (1 .. $#M) {
	my @L;
	for my $word1 (@list) {
	    for my $word2 (@{$M[$i]}) {
		my $sentence = join " ", $word1, $word2;
		push @L, $sentence;
	    }
	}
	@list = @L;
    }
    @list = uniq @list;
    return @list;
}

sub proc($l1, $l2, $l3) {
    print "Input: \$list1 = @$l1\n \$list2 = @$l2\n \$list3: ";
    print "@$_; " for (@$l3);
    print "\n";
    my $o = "false";
    if (@$l3 == 0) {
	$o = "true";
    } else {
	my $target = join " ", @$l1;
	my @L = swap($l2, $l3);
	for my $l (@L) {
	    $o = "true" if ($l eq $target);
	}
    }

    say "Output: $o";
}

my $list1 = ["great", "acting"];
my $list2 = ["fine", "drama"];
my $list3 = [["great", "fine"], ["acting", "drama"]];
proc($list1, $list2, $list3);

$list1 = ["enjoy", "challenge"];
$list2 = ["love", "weekly", "challenge"];
$list3 = [["enjoy", "love"]];
proc($list1, $list2, $list3);
