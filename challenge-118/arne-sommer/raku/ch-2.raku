#! /usr/bin/env raku

subset ChessPos of Str where
  $_.chars == 2 &&
  $_.substr(0,1) ~~ /<[abcdefgh]>/ &&
  $_.substr(1,1) ~~ /<[12345678]>/;

unit sub MAIN (ChessPos $pos = 'a8', :v($verbose));
  
my ($col, $row) = $pos.comb;

my %treasures = ('e6' => True, 'c4' => True, 'b3' => True,
                 'a2' => True, 'b2' => True, 'b1' => True);
		 
my %visited   = ('a8' => True);

my @todo = ( ('a8', 'a8', {%visited}, {%treasures}), );

while @todo
{
  my $next      = @todo.shift;
  my ($pos, $path, $visited, $treasures) = @($next);
  my %visited   = %($visited);
  my %treasures = %($treasures);

  for get-next($pos) -> $next
  {
    say ": Checking pos: $next (at path \'$path\') with { %visited.elems } visits and { %treasures.elems } remaining treasures" if $verbose;
    next if %visited{$next};

    if %treasures{$next}
    {
      if %treasures.elems == 1
      {
        say "Path: $path $next";
        exit;
      }

      %treasures{$next}:delete;
    }
    %visited{$next} = True;
    @todo.push: ($next, "$path $next", {%visited}, {%treasures});
  }
}

sub get-next ($pos)
{
  my ($col, $row) = $pos.comb;
  
  my @next = (
    "{ ($col.ord - 2).chr }{ $row - 1 }",  # LLD
    "{ ($col.ord - 2).chr }{ $row + 1 }",  # LLU
    "{ ($col.ord - 1).chr }{ $row - 2 }",  # LDD
    "{ ($col.ord - 1).chr }{ $row + 2 }",  # LUU
    "{ ($col.ord + 1).chr }{ $row - 2 }",  # RDD
    "{ ($col.ord + 1).chr }{ $row + 2 }",  # RUU
    "{ ($col.ord + 2).chr }{ $row - 1 }",  # RRD
    "{ ($col.ord + 2).chr }{ $row + 1 }",  # RRU
  ).grep( * ~~ ChessPos);

  return @next;
}