unit module packy-anderson::raku::task-one:ver<0.0.1>:auth<packy-anderson@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/packy-anderson/raku/ test/challenge-nr233/raku/task-one.rakutest

#|[
Individual task description and interesting solution hints ...
]
sub charsInWord(Str $word) {
  # split the word into characters, then use the Raku
  # array method unique to have each character appear once.
  return $word.split('').unique.sort.join;
}

sub findSimilarWordPairs(*@words where ($_.all ~~ Str)) {
  my %similar;
  for @words -> $word {
    my $charset = charsInWord($word);
    %similar{$charset}.push($word);
  }

  # filter out character sets that only have one word
  my @multiples = %similar.keys.grep: {
    %similar{$_}.elems > 1
  };

  # make pairs by looping over the list
  # of letter sets that had multiple entries
  my @pairs;
  for @multiples -> $charset {
    # if we assign @list = %similar{$charset}, we get
    # an array with a single element, an array object.
    # By using .splice, I can get all the elements in 
    # the array object assigned to @list
    my @list = %similar{$charset}.splice(0, *);

    while ( @list.elems >= 2 ) {
      # remove the first word from the list of words
      my $first = @list.shift;
      # pair it with each of the remaining words
      for @list -> $second {
        @pairs.push([ $first, $second ]);
      }
    }
  }
  return @pairs;
}

our sub solution(@words) is export {

  my @pairs = findSimilarWordPairs(@words);

  my $count = 0;
  for @pairs -> $pair {
  	++$count;
  }
  return $count;
}