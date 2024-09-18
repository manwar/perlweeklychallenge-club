use strict;
use warnings;
my $filename = $0;
my @array;

open FH,'<',$filename or die "can't open source code";

while(my $script = <FH>){
  #chomp($script);
  $script =~ s/^\s+//;
  #print $script;
  my @temp = split(/\s/,$script);
  push @array, @temp;
}
close(FH) or die "can't close file $filename";

print "\n[";
print join(",",@array);
print "]";

