use v6;

# AUTHOR: Robert DiCicco
# DATE: 20-APR-2022
# Challenge 161 Pangrams ( Raku )

my %usage;                # Hash to hold what words have been used
my @flines;               # Array to hold the Abecedarian words generated
                          # in previous execise.

sub CreateWordArray() {                 # Read the Abecedarian words into an array.
  for open('PangramWords.txt').lines    # I really hate that word!
  {
    my $word = $_;
    $word = $word.trim-leading;
    $word = $word.trim-trailing;
    @flines.push: $word;
    %usage{$word} = 0;                  # Create the hash entry with a value of 0
  }
}

sub FindRandomWord( $c ) {              # Find a word that contains the given char.
  my $Story = True;                     # and check to see if it has not been used
  my $counter = 1;
  while ( $Story ) {
    my $x = @flines.pick;
    if (( $x.contains($c)) && (%usage{$x} == 0)) {
      %usage{$x} = 1;
      return $x;
    }

    $counter++;                         #  Counter to prevent runaway looping.
    if $counter > 1500 { return $c;}    # Just return the char if nothing was found
  }
}

sub MAIN () {

  CreateWordArray;

  for ('a' .. 'z').pick(26) -> $ch {
    my $retword = FindRandomWord($ch);
    print "$retword ";
  }

  print "\n";
}
