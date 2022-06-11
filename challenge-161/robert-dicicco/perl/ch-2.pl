#!perl.exe

use strict;
use warnings;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 18-APR-2022
# Challenge 161 Pangrams ( Perl )

my %alphabet;
my %lettercnt;

my $cnt = 0;
my $file = 'PangramWords.txt';       # Pangram which contains only abecedarian words (see challenge 1)

sub ReadRandomLine {

  open(FH ,'<', $file)  or die $!;

  my $size = -s FH;
  seek FH, rand($size) , 0;
  <FH>; # throw away current line;

  my $randomline = <FH>;

  if($randomline){
    $randomline =~ s/^\s+|\s+$//g;   # trim left and right
    return($randomline);
    close FH;
  }

  close FH;
}

sub analyze {
  my $word = shift;

  my @arr = split(//,$word);             # split to individual letters
  foreach my $letter (@arr){
    next if $letter !~ /[a-z]/;

    if (! exists($alphabet{$letter})) {  # set char value in array if not there
      $alphabet{$letter} = 1;
    }
  }
}

print "Uses Abecedarian words from Challenge 1:\n";

while(1) {

  my $new = ReadRandomLine();
  if($new){
    analyze($new);
  }

  my $size = keys %alphabet;          # how many letters we have used

  if (! exists($lettercnt{$size})) {
    $lettercnt{$size} = 1;
    print "$new ";
  }

  last if( $size == 26 );      # we have them all
}

print "\n";
print "Letters used: ";

foreach my $name (sort keys %alphabet) {
        print $name;
}

print "\n";
