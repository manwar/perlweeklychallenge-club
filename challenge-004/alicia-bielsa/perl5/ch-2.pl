#Challenge #2
#
#   You are given a file containing a list of words (case insensitive 1 word per line) and a list of letters.
#Print each word from the file than can be made using only letters from the list.
#You can use each letter only once (though there can be duplicates and you can use each of them once), you don’t have to use all the letters.
#(Disclaimer: The challenge was proposed by Scimon Proctor)
use strict;
use warnings;

my $fileWithWords = 'file.txt';
my @aWordsFromFile = readLinesFromFile($fileWithWords);

#Letters must be lowercase
my @aListOfLetters = qw(h o l a e t s p r r k k a n w z d);
my %hLettersAvailable = arrayToHash( \@aListOfLetters );


foreach my $wordFromFile (@aWordsFromFile){
    if (canWordBeMade( $wordFromFile )){
     print "$wordFromFile\n";
    }
}

sub readLinesFromFile {
  my $file = shift;
  my @aLines =();
  unless ( -f $file) {
    die "ERROR: File '$file' does not exist\n";
  }
  open (my  $fh, '<', $file) or die "ERROR: Unable to open file '$file':'$!'\n";
  while (my $line = <$fh>) {
    $line =~ s%^\s+%%;
    $line =~ s%\s+$%%;
    next unless ($line);
    push (@aLines,lc($line));
  }
  close ($fh);
  return @aLines ;

}

sub arrayToHash {
  my $refArray = shift;
  my %hHash = ();
  foreach my $item (@{$refArray}){
    if (exists($hHash{$item})){
    	$hHash{$item} ++;
    } else {
        $hHash{$item} = 1;
    }
  }
  return %hHash;
}

sub canWordBeMade {
    my $wordToCheck = shift;
    my $canBeMade = 0;
    my %hLettersToUse = %hLettersAvailable;
    foreach my $letterInWord (split(//, $wordToCheck)){
      if (exists($hLettersToUse{$letterInWord})  && $hLettersToUse{$letterInWord}){
        $hLettersToUse{$letterInWord}--;
      } else {
        return $canBeMade;
      }
    }
    return 1;
}

exit 0;
