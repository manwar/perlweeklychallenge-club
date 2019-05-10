#!/usr/bin/env perl6

use v6.d;

#| Finds the count of characters that do not match between two words.
sub word-distance(Str $word-a, Str $word-b --> Int) {
  [+] ($word-a.comb Z $word-b.comb).map: { .[0] ne .[1] };
}

#| Find the shortest word ladder between $to and $from in file $wordlist
multi find-shortest-ladder(Str $from, Str $to, IO $wordlist --> List) {
  # Generate a set of words from the given input file.
  # Not assuming is that all words are of the same length in the input file
  # so I can use /usr/share/dict/* again
  my Set $words = $wordlist.words.grep(-> $word { $word.chars == $from.chars }) (-) $from;

  # Defer to set function
  find-shortest-ladder($from, $to, $words);
}

#| Find the shortest word ladder between $to and $from in set $words
multi find-shortest-ladder(Str $from, Str $to, Set $words is copy --> List) {
  word-distance($from, $to) == 1 and return [$from, $to];
  
  # Initial list of candidate ladders whould include the from word
  my @candidates = $from;

  # Use channel for breadth first processing
  my Channel $c .= new;

  my $result;

  # Attempt to progress candidate ladders when there are any available
  while @candidates.all ~~ Str {
    # Terminate loop and return any results from ladder progression function
    last if ($result = progress-ladder(@candidates, $to, $words, $c));
    # Get the next ladder of candidates from the channel.
    @candidates = $c.poll;
  }

  $c.close;

  $result || Empty;
}


#| Callback to produce new candidate ladders from the current one.
#  $words is rw so we can progressively reduce the size of the set.
my sub progress-ladder(@candidates, Str $to, Set $words is rw, Channel $c) {
  # Get tail end of the ladder; don't try to do anything otherwise.
  my $from = @candidates[*-1] or return;

  # Get the current distance from the to word
  my $distance = word-distance($from, $to);

  # Generate a list of words have a distance of one from the tail of the ladder.
  my @next = $words.keys.race.grep: -> $word {
    word-distance($from, $word) == 1
  }

  if @next {
    # Remove the found words from the available set.
    # 1. Reduces computation time for the next candidates.
    # 2. Prevents generation of infinite loops.
    # 3. Doesn't matter if a longer ladder could have had the same word.
    # 4. Will limit the options for other ladders of the same length, but only by a small amount.
    $words (-)= @next;

    # Randomise the order of the tail words and generate new candidate ladders
    for @next.pick(*) -> $tail {      
      my @candidates-n = |@candidates, $tail;
      
      # If our distance to the to word is 1, shortcut the process and return the completed ladder.
      $distance <= 2 && word-distance($tail, $to) <= 1 and return @candidates-n.push($to);

      # Queue the candidate ladder for processing ($c might be closed though).
      try $c.send: @candidates-n;
    };
  }
}

unit sub MAIN($from = 'cold', $to = 'warm', :$dict = 'example.txt');

say find-shortest-ladder($from, $to, $dict.IO);
