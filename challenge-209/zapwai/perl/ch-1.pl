use v5.30.0;
my @bits = (1, 0, 0);
#my @bits = (1, 1, 1, 0);
say "Input: \@bits = (".join(", ",@bits).")";
my $out;
do {
    if (($bits[0] == 1) && ($bits[1] == 0)) {
	$out .= 'b';
	shift @bits;
	shift @bits;	
    } elsif (($bits[0] == 1) && ($bits[1] == 1)) {
	$out .= 'c';
	shift @bits;
	shift @bits;		
    } elsif ($bits[0] == 0) {
	$out .= 'a';
	shift @bits;
    }
} while ($#bits + 1);
my @let = split("",$out);
print "Output: ";
if ($let[$#let] eq 'a') {
    print "1";
} else {
   print "0";
}
say "\t(Decodes to $out)";
