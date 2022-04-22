#!perl.exe

use strict;
use warnings;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 18-APR-2022
# Challenge 161 Abecedarian Words ( Perl )

######      Bees bellow in bop cellos!  ß---------------

my @sorted;
my @elements;

sub wordCheck {
  my $word = shift;

  my $new = join('',sort(split(//,$word)));     # split the word, sort it,
                                                # compare sorted value to supplied value
  if ($new eq $word){                           # return 1 if equal, else return 0
    return(1);
  }

  return(0);
}

sub printByLengthDesc {

  @sorted = sort { length($b) <=> length($a) } @_;    # sorted by descending length

  my $cnt = 0;

  #my $row = 1;

  foreach (@sorted) {
    print("$sorted[$cnt] ");
    $cnt++;

    if(($cnt % 24) == 0){
      print "\n";
    }
  }

  print "\n";
}

sub main {

  # ARGV[0] points to your dictionary file
  # Usage: ./Abecedarian.pl "your_dict_file.txt"

  open(FP, '<', $ARGV[0]) or die "Can't open $ARGV[0]. $!\n";

  while(my $word = <FP>){
    chomp($word);
    if ( $word =~ /^[A-z]*/) {
      my $retval = wordCheck($word);
      if ($retval == 1 ) {
        push(@elements, $word);
      }
    }
  }

  close(FP);

  printByLengthDesc(@elements);
}

main();
