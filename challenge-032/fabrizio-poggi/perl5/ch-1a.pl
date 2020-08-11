use strict;
use warnings;

my $filename = 'fruits.txt';

open(my $fh, $filename)
  or die "Could not open file '$filename' $!";
chomp(my @lines = <$fh>);
close $fh;

my $count = 0;
my $line = "";

my $temp = "@lines";
print "Weekly Challenge 32";
print "\n--- Fruits cvs -------\n";

for $line (@lines) {
if ($count = $temp =~ s/($line)//g) {
printf("%s,%s\n", $line, $count);
   }
}
