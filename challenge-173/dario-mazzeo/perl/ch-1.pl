# THE WEEKLY CHALLENGE - 173
# Task 1: Esthetic Number
# Autore: Dario Mazzeo

my $num=$ARGV[0];
#my $num=5456;
#my $num=120;

if ($num<1){print "0\n"; exit;}
my $t=-1;
foreach (my $i=0; $i<length($num)-1; $i++){
	if ($t>1 || ($t!=-1 && $t!=Valore($num, $i))){print "0\n"; exit;}
	$t=Valore($num, $i);
}
print "1\n";
exit;


sub Valore{
my $num=$_[0];
my $i=$_[1];

return abs(int(substr($num,$i,1))-int(substr($num,$i+1,1)));
}