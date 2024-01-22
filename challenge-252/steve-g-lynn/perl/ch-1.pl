# Perl 4.019 on DOSBOX

sub special_numbers {
    local (@ints)=@_;
    local ($n) = scalar(@ints);
    local ($i);
    local ($retval) = 0;
    foreach $i (1 .. $n) {
	($n % $i) || ($retval += ($ints[$i-1] * $ints[$i-1]) );
    }
    $retval;
}

print &special_numbers(1,2,3,4),"\n"; #21
print &special_numbers(2,7,1,19,18,3),"\n"; #63

