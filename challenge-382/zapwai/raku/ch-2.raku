use v6;

sub proc($str) {
    say "Input: \$str = \"$str\"";
    if $str ~~ /\?/ {
	my @char = $str.comb;
	my @branch;
	my $index = 0;
	for 0 .. @char.end -> $ind {
	    if @char[$ind] eq '?' {
		$index = $ind;
		@branch.push(substr $str, 0, $ind - 0);
		last;
	    }
	}
	for $index .. @char.end -> $ind {
	    if @char[$ind] eq '?' {
		my @B;
		for @branch -> $pre {
		    for 0, 1 {
			my $o = $pre ~ $_;
			@B.push($o);
		    }
		}
		@branch = @B;
	    } else {
		for 0 .. @branch.end {
		    @branch[$_] ~= @char[$ind];
		}
	    }
	}
	say "Output: ", @branch;
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
