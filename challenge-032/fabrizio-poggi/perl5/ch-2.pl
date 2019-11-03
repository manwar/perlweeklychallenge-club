use strict;
use warnings;

my $filename = 'fruits.txt';

open(my $fh, $filename)
  or die "Could not open file '$filename' $!";
chomp(my @lines = <$fh>);
close $fh;

my $count = 0;
my $line = "";
my $sep = "|";
my $hashtag = "";

my $temp = "@lines";
print "\n--- Fruits hashtag ---\n";

for $line (@lines) {
if ($count = $temp =~ s/($line)//g) {
$hashtag = "#"x$count;
format HASHES =
@<<<<<<<<<<< @| @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$line, $sep, $hashtag
.
select(STDOUT);
$~ = "HASHES";
write;
   }
}
