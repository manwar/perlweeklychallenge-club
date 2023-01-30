use v5.30.0;
my @array = (1,2,3,4);
#my @array = (1,2,3,5,7,9,10,11,14);
#my @array = (1,2,3,5,7,9,10,11,14,5,32,33,40,43,46,49);

sub wrap {
    my @array = @_;
    "(" . join(",", @array).")"
}

# return all sets of size 3+
sub bundle {
    my $len = @_;
    my $str; 
    unless (@_ < 4) {
	do {
	    $len--;
	    for (0 .. @_ - $len) {
		my @list;
		for my $i ($_ .. $_ + $len - 1) {
		    push @list, $_[$i];
		}
		$str .= wrap(@list).", ";
	    }
	} while ($len > 3);
    }
    $str .= wrap(@_);    
    print $str;
}

say "Input: \@array = " . wrap(@array);
if ($#array < 2) {
    say "Output: No slice found."; exit;
}

# indices as we traverse list
my $begin = 0;
my $end = 0;			

my @begin;
my @end;

$begin[0] = 0 if ($array[2] - $array[1] == $array[1] - $array[0]);
for my $i (0 .. $#array - 2) {
    next if ($i < $end);
    $begin = $i;    
    my $diff = $array[$i + 1] - $array[$i];
    for my $j ($i + 1 .. $#array - 1) {
	if ($array[$j + 1] - $array[$j] == $diff) {
	    $end = $j + 1;
	    push @begin, $begin unless ($begin[$#begin] == $begin);
	} else {
	    last if (($end == 0) or ($end[$#end] == $end));
	    push @end, $end;
	    last;
	}
    }
}
push @end, $end if (@begin != @end);
print "Output: ";
for my $i (0 .. $#begin - 1) {
    bundle @array[$begin[$i] ..  $end[$i]];
    print ", ";
}
bundle @array[$begin[$#begin] ..  $end[$#begin]];
say;
