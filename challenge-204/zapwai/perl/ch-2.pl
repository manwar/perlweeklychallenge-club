use v5.30.0;
my $matrix = [ [ 1, 2 ], [ 3, 4 ] ];
my ($r,$c) = (1,4);
my @flat;
print "Input: (\$r,\$c) = ($r,$c)\n";
foreach (@$matrix) {
    push @flat, @$_ ;
    say "\t[@$_]";
}
if (@flat != $r*$c) {
    say "Output: 0\n";
    exit;
}
print "Output: \n";
for (1 .. $r) {
    print "\t[ ";
    for (1 .. $c) {
	print shift @flat, " ";
    }
    say "]";    
}
