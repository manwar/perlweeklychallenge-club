#! /usr/bin/env perl6

multi sub MAIN ($first, $second, *@wordlist, :$all)
{
  say-output(find_shortest_ladder($first, $second, @wordlist, $all));
}

multi sub MAIN ($first, $second, $dictionary where $dictionary.IO && $dictionary.IO.r, :$all)
{
  return unless $first.chars == $second.chars;
  
  my @wordlist = load-dictionary($dictionary, $first.chars);
    # Only load the words with the correct length.
  
  sub load-dictionary ($file where $file.IO && $file.IO.r, $word-length)
  {
    return $file.IO.lines.grep({ .chars == $word-length }).lc.words;
  }
  
  say-output(find_shortest_ladder($first, $second, @wordlist, $all));
}

sub say-output(@list)
{
  for (@list) -> $curr
  {
    say '("', $curr.split(";").join('","'), '")';
  }
}

sub find_shortest_ladder ($word1, $word2, @wordlist, $show-all)
{
  my Set $dict := @wordlist.Set;
  my @letters = @wordlist.comb.unique.grep({ /<:L>/ });

  return unless $dict{$word1};
  return unless $dict{$word2};
  return unless $word1.chars == $word2.chars;
  return unless all(@wordlist>>.chars) == $word1.chars;

  my @solutions;
  my $solution-found = False;
  my $solution-found-size = 0;
  
  my @deferred = ($word1);

  loop
  {
    my $current = @deferred.shift // last;
    
    check-path($current, $word2);

    last if $solution-found && !$show-all;
  }
  
  sub check-path($path, $stop)
  {
    my @path = $path.split(";");
    my $seen = @path.Set;
    
    if $solution-found
    {
      return if $solution-found-size == @path.elems;
    }

    my $current = @path[*-1];

    my $next-word := gather
    {
      for ^$current.chars -> $index
      {
        my $next = $current;
        for @letters -> $letter
        {
          $next.substr-rw($index, 1) = $letter;
          next if $current eq $next;
          take $next if $dict{$next};
        }
      }
    }

    for $next-word -> $candidate
    {    
      next if $seen{$candidate};

      if $candidate eq $stop
      {
        @solutions.push("$path;$candidate");
	$solution-found = True;
        $solution-found-size = @path.elems + 1;
      }
      else
      {
        @deferred.push("$path;$candidate");
      }
    }
  }
  return @solutions;
}
