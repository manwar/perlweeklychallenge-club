#! /usr/bin/env raku

unit sub MAIN (*@matrix where @matrix.elems > 0 && ( [==] @matrix>>.elems ) && all(@matrix) ~~ /^<[ox]>+$/, :v(:$verbose));

my @m = @matrix>>.comb>>.Array;

print-matrix(@m) if $verbose;

my $current = 1;

my %replace;

for ^@m.elems -> $row
{
  for ^@m[0].elems -> $col
  {
    my $curr = @m[$row][$col];
    my $todo = $curr eq any('o', 'x');
    
    say ": Loop iteration at r:$row c:$col val:$curr - { $todo ?? "Enter, todo" !! "Skip, already done" }" if $verbose;
    
    next unless $todo;

    %replace{$current} = $curr;

    $current++ if set-value(@m, $row, $col, $curr, $current);
  }
}

sub set-value(@m, $row, $col, $swap, $replace)
{  
  return unless 0 <= $row < @m.elems;
  return unless 0 <= $col < @m[0].elems; 
  return unless @m[$row][$col] eq $swap;

  say ": - r:$row c:$col | Replace @m[$row][$col] with $replace" if $verbose;

  @m[$row][$col] = $replace;

  set-value(@m, $row -1, $col,    $swap, $replace);
  set-value(@m, $row,    $col -1, $swap, $replace);
  set-value(@m, $row,    $col +1, $swap, $replace);
  set-value(@m, $row +1, $col,    $swap, $replace);

  return True;
}

print-matrix(@m) if $verbose;

my $bag    = @m[*;*].Bag;
my @sorted = $bag.sort({ $^b.value <=> $^a.value });

say ": Bag { $bag.raku }" if $verbose;
say ": Bag Sort: { $bag.sort({ $^b.value <=> $^a.value }).raku }" if $verbose;

print-matrix(@m, @sorted.first.key) if $verbose;

say @sorted.first.value;

multi sub print-matrix (@m)
{
  @m.map({ say ": " ~ $_.join(" ") });
}

multi sub print-matrix (@m, $match)
{
  my $col-blue  = "\e[44m";
  my $col-green = "\e[42m";
  my $col-red   = "\e[101m";
  my $col-stop  = "\e[0m";

  for @m -> @row
  {
    say ": " ~ @row.map({ $_ == $match ?? "$col-green%replace{$_}$col-stop" !! %replace{$_}  }).join(" ");
  }
}
