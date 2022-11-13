#! /usr/bin/env raku

# unit sub MAIN ($s where $s ~~ /^<[1..9]> <[0..9]>*$/, :v(:$verbose));

unit sub MAIN ($s where $s ~~ /^<[0..9]>*$/, :v(:$verbose));

my $seq := gather { recurse( (), $s.comb); };

say $seq.join(", ");

sub recurse(@done is copy, @todo is copy)
{
  unless @todo.elems
  {
    my $string = @done.map({ ($_ + 'A'.ord - 1).chr }).join;
    say ":Take: @done[] -> $string" if $verbose;

    take $string;
    return;
  }
  
  my $next  = @todo.shift;
  my @done2 = @done.clone;
  my @todo2 = @todo.clone;

  return if $next == 0;

  say ":Loop: @done2[] + $next" if $verbose;

  @done.push: $next;
  recurse(@done, @todo);

  if @todo.elems
  {
    $next ~= @todo2.shift;

    return if $next > 26;
    
    say ":Loop: @done2[] + $next" if $verbose;
    @done2.push: $next;
    recurse(@done2, @todo2);
  }
}
