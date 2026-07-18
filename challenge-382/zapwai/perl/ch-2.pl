use v5.38;

sub proc($str) {
    say "Input: \$str = \"$str\"";
    if ($str =~ /\?/) {
	my @char = split '', $str;
	my @branch;
	my $index;
	for my $ind (0 .. $#char) {
	    if ($char[$ind] eq '?') {
		$index = $ind;
		push @branch, substr $str, 0, $ind - 0;
		last;
	    }
	}
	for my $ind ($index .. $#char) {
	    if ($char[$ind] eq '?') {
		my @B;
		for my $pre (@branch) {
		    for (0, 1) {
			my $o = $pre."$_";
			push @B, $o;
		    }
		}
		@branch = @B;
	    } else {
		for (0 .. $#branch) {
		    $branch[$_] .= $char[$ind];
		}
	    }
	}
	say "Output: @branch";
    } else {
	say "Output: $str";
    }
}

my $str = "01??0";
proc($str);
$str= "101";
proc($str);
$str = "???";
proc($str);
$str = "1?10";
proc($str);
$str = "1?1?0";
proc($str);
