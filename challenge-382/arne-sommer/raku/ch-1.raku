#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 1, :v(:$verbose));

my %perfect-squares = (2 .. (2*$n).sqrt.Int).map: { $_ ** 2 => True };

say ":Perfect squares: { %perfect-squares.keys.sort({ $^a <=> $^b }).join(", ") }" if $verbose;

my @done = 1,;
my %todo = (2 .. $n).map: * => True;

say recurse(@done, %todo) ?? @done.join(", ") !! "()";

sub recurse (@done, %todo)
{
  return %perfect-squares{ @done[*-1] + @done[0] } unless %todo;

  my $current = @done[*-1];

  for %todo.keys.sort({ $^a <=> $^b }) -> $candidate
  {
    my $is-perfect = %perfect-squares{$current + $candidate};

    say ":Considering { @done.join(",") } + $candidate -> { $is-perfect ?? "ok" !! "not ok, backtrack" }" if $verbose;

    next unless $is-perfect;
    
    @done.push: $candidate.Int;
    %todo{$candidate}:delete;

    return True if recurse(@done, %todo);

    @done.pop;
    %todo{$candidate} = True;
  }

  return False;
}
