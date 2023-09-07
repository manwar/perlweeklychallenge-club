unit module challenge-nr233::packy-anderson::raku::task-two:ver<0.0.1>:auth<packy-anderson@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/packy-anderson/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]

our sub solution(@ints) is export {
  # count how often each integer occurs
  my %counts;
  for @ints -> $int {
    %counts{$int}++;
  }

  # now create a hash of arrays listing which integers
  # occur at what frequencies
  my %frequency;
  for %counts.keys -> $int {
    %frequency{ %counts{$int} }.push($int);
  }

  my @output;
  my $text;
  for %frequency.keys.sort -> $freq {
    my @list = %frequency{$freq}.splice(0, *);
    # get each integer for this frequency in descending order
    for @list.sort.reverse -> $int {
      # we need to put the integer on the list $freq times
      @output.append($int xx $freq);
    }
  }
  return @output;
}