
#----optimize for brevity:
#print [ sort {$b <=> $a} map {//; map 0+$_ ^ 0+$', @ARGV } @ARGV ]->[0];
#print "\n";


#---- or optimize for clarity:
my $highest;
for my $a (@ARGV){
for my $b (@ARGV){
    my $xor = 0+$a ^ 0+$b;
    $highest = $xor if not defined $highest
	            or $xor > $highest;
}}
print "$highest\n";
