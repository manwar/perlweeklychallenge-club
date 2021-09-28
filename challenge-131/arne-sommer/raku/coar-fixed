#! /usr/bin/env raku

multi MAIN (Str $input = "1 2 3 6 7 8 9", :v(:$verbose))
{
  my @input = $input.words;
  MAIN(@input, :$verbose);
}

multi MAIN (*@input where @input.elems > 1 && all(@input) ~~ /^\d+$/, :v(:$verbose))
{
  die "Not sorted" unless [<] @input;

  my @result;
  my $current = @input.shift;
  my @current = $current,;

  say ": Candidate: $current" if $verbose;

  for @input -> $i
  {
    if $i > $current +1
    {
      @result.push: @current.clone;
      say ": Push: [", @current.join(","), "]" if $verbose;
      @current = ();
    }
  
    say ": Candidate: $i" if $verbose;
  
    @current.push: $i;
    $current = $i;
  }

  @result.push: @current if @current;

  say '(' ~ @result.map({ '[' ~ @$_.join(', ') ~ ']' }).join(', ') ~ ')';
  
}
