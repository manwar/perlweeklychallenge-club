#! /usr/bin/env raku

unit sub MAIN (:$S = "(1,4),(8,10)", :$N ="(2,6)", :v(:$verbose));

my $s = $S.EVAL;
my $n = $N.EVAL;

class interval
{
  has $.start;
  has $.stop;

  method inside ($value)
  {
    return $.start <= $value <= $.stop;
  }

  method mergable (interval $new)
  {
    return True if $.start -1 < $new.start < $.stop +1;
    return True if $.start -1 < $new.stop  < $.stop +1;
    return False;	
  }
  method merge (interval $new)
  {
    return interval.new(start => min($.start, $new.start),
                        stop  => max($.stop,  $new.stop));
  }
  method Str
  {
    return "({ $.start },{ $.stop })";
  }
}

my @all = @$s.map({ interval.new(start => $_[0], stop => $_[1]) });
my $m = interval.new(start => $n[0], stop => $n[1]);

@all.push($m);

@all = @all.sort: { $^a.start <=> $^b.start ||  $^a.stop <=> $^b.stop };

my @result;

my $first = @all.shift;

loop
{
  last unless @all.elems;

  my $second = @all.shift;
  if $first.mergable($second)
  {
    # say ":m" if $verbose;
    my $new = $first.merge($second);
    $first = $new;
    next;
  }
  elsif $first.stop < $second.start + 1
  {
    # say ":<" if $verbose;
    @result.push($first);
    $first = $second;
    next;
  }
  else
  {
    # say ":>" if $verbose;
    @result.append($first, $second, @all);
    $first = Any;
    last;
  }
}

@result.push($first) if $first;

say @result.join(", ");
