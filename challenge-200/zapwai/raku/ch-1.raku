my @array = (1,2,3,4);
#my @array = (1,2,3,5,7,9,10,11,14,5,32,33,40,43,46,49);
sub wrap (@arr) {
    return "(" ~ join(",", @arr) ~ ")"
}

sub bundle (@arr) {
    my $len = @arr.elems;
    my $str; 
    unless ( @arr.elems < 4 ) {
	repeat {
	    $len--;
	    for (0 .. @arr.elems - $len) {
		my @list;
		loop (my $i = $_; $i <= $_ + $len - 1; $i++) {
		    push @list, @arr[$i];
		}
		$str ~= wrap(@list) ~ ", ";
	    }
	} while ($len > 3);
    }
    $str ~= wrap(@arr);    
    print $str;
}

say "Input: \@array = " ~ wrap(@array);
if (@array.elems < 3) {
    say "Output: No slice found."; exit;
}

my $begin = 0;
my $end = 0;			

my @begin = (-1);
my @end = (-1);

@begin[1] = 0 if (@array[2] - @array[1] == @array[1] - @array[0]);
loop (my $i = 0; $i < @array.elems - 2; $i++) {
    next if ($i < $end);
    $begin = $i;    
    my $diff = @array[$i + 1] - @array[$i];
    loop (my $j = $i + 1; $j < @array.elems - 1; $j++) {
	if (@array[$j + 1] - @array[$j] == $diff) {
	    $end = $j + 1;
	    push @begin, $begin unless (@begin.tail == $begin);
	} else {
	    last if (($end == 0) or (@end.tail == $end));
	    push @end, $end;
	    last;
	}
    }
}
push @end, $end if (@begin.elems != @end.elems);
print "Output: ";

shift @begin;
shift @end;

loop (my $k = 0; $k < @begin.elems - 1; $k++) {
    bundle @array[@begin[$k] ..  @end[$k]];
    print ", ";
}
bundle @array[@begin.tail ..  @end.tail];
say "";
