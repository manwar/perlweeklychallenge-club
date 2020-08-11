#! /usr/bin/env perl6

my @names = <audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask>;

my @start = @names.map( *.substr(0,1) ).unique;

my %start-list;

for @start -> $letter
{
  %start-list{$letter} = @names.grep(*.substr(0,1) eq $letter);
}

my $length = 0;
my @solution;

for @names -> $name
{
  do-check( $name.List );
}

for @(@solution) -> @sol
{
  say "{ @sol.elems }: { @sol }";
}

say "Total: { @(@solution).elems } solutions.";

sub do-check (@path)
{
  my $last = @path[*-1];
  my $last-letter = $last.substr(*-1,1);

  my $found-next = False;
  
  if %start-list{$last-letter}
  {
    for @(%start-list{$last-letter}) -> $next-name
    {
      next if $next-name eq any( @path );
      
      my @new = @path; @new.push: $next-name;
      $found-next = True;
      do-check(@new);
    }
  }
  unless $found-next
  {
    my $current-length = @path.elems;
    
    return if $current-length < $length;

    if $current-length > $length
    {
      @solution = ();
      $length = $current-length;
      say "Currently longest path found at $current-length.";
    }
    
    @solution.push(@path);
  }
}
