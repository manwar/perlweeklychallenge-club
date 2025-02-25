#! /usr/bin/env raku

subset PosInt of Int where * >= 0;

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ PosInt,
               :v(:$verbose));

my %freq = @ints.BagHash;

say ": Initial Status:\n", %freq.keys.sort.map({ ": - value $_ -> count " ~ %freq{$_} }).join("\n") if $verbose;

my $points  = 0;
my @sorted  = %freq.keys.sort;
my @current = (@sorted.shift,);

while @sorted || @current
{
  my $next = @sorted.elems ?? @sorted.shift !! Nil;

  if !$next || @current.tail +1 != $next
  {
    my $add  = resolve-wrap(@current);
    $points += $add;
    
    if $verbose
    {
      say ": ------------------------------------------" ;
      say ": Adding $add points -> $points from ({ @current.join(",") })";
    }

    @current = ();
  }
  @current.push: $next if $next;
}

say $points;

sub resolve-wrap (@current where [<] @current)
{
  my $max = 0;

  say ": ------------------------------------------" if $verbose;
  
  for @current.permutations -> @perm
  {
    say ": ------------------------------------------" if $verbose;
    
    if @perm.elems % 2 && @perm.head > @perm.tail
    {
      say ": Skipped order @perm[] and onwards as the reverse has been done" if $verbose;

      last;
    }

    say ": Trying order @perm[]" if $verbose;

    my $points-add = resolve(%freq, @perm);

    if $points-add  > $max
    {
      $max = $points-add;

      say ": + New max: { $max }" if $verbose;
    }
    elsif $verbose
    {
      say ": - Not a new max: $points-add (current max: $max)";
    }
  }

   %freq{$_} :delete for @current;

  return $max;
}

sub resolve (%freq is copy, @perm)
{
  my $points = 0;

  for @perm -> $current
  {
    next unless %freq{$current};  ## As :delete can do away with it.

    my $prev = $current -1;
    my $next = $current +1;

    $points += $current * %freq{$current};

    if $verbose
    {
      say ": Deleted value $current (count %freq{$current}) -> Points: $points";
      say ":   Deleted neighbour $prev" if %freq{$prev};
      say ":   Deleted neighbour $next" if %freq{$prev};
    }

    %freq{$current} :delete;
    %freq{$prev}    :delete if defined %freq{$prev};
    %freq{$next}    :delete if defined %freq{$next};
  }

  return $points;
}