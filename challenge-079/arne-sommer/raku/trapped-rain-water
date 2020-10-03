#! /usr/bin/env raku

unit sub MAIN (*@N where @N.elems > 0 && all(@N) ~~ Int && all(@N) > 0, :v(:$verbose), :s(:$show), :h(:$html));

if @N.elems == 1|2
{
  say 0;
  exit;
}

my $col-blue  = "\e[44m";
my $col-green = "\e[42m";
my $col-red   = "\e[101m";
my $col-stop  = "\e[0m";
my $col-swap  = "";

if ($html)
{
  $col-blue  = '<span class="text-light bg-primary">';
  $col-green = '<span class="text-light bg-success">';
  $col-red   = '<span class="text-light bg-danger">';
  $col-stop  = '</span>';
  $col-swap  = '</span>';
}

my $old-sum = @N.sum;
my $elems   = @N.elems;
my @N-new   = @N;

say ": Old sum: $old-sum" if $verbose;

for 0 .. $elems -3 -> $left
{
  for $elems -1 ... $left +2 -> $right
  {
    show-sliding-window($left, $right, $col-green, "Before filling", @N-new) if $verbose;

    my @old = @N-new;
    
    my $L = @N-new[$left];
    my $R = @N-new[$right];
    my @A = @N-new[$left+1 .. $right-1];

    my $min = min($L, $R);

    if $min > any (@A)
    {
      for $left+1 .. $right-1 -> $index
      {
         @N-new[$index] = $min if @N-new[$index] < $min;
      }
    }
    show-sliding-window($left, $right, $col-blue, "After filling ", @old) if $verbose;
  }
}

my $new-sum = @N-new.sum;

say ": New sum: $new-sum" if $verbose;

show-histogram if $show;

say $new-sum - $old-sum;

sub show-sliding-window($left, $right, $col, $label, @old)
{
  print ": $label: ";

  for ^@N -> $index
  {
    if $index < $left || $index > $right
    {
      print @N-new[$index] ~ " ";
    }
    elsif @N-new[$index] == @old[$index]
    {
      print $col ~ @N-new[$index] ~ " " ~ $col-stop;
    }
    else
    {
      print $col-red ~ @N-new[$index] ~ " " ~ $col-stop;
    }
  }
  print "\n";
}

sub show-histogram
{
  my $rows = @N.max;
  my $cols = @N.elems;

  for $rows ... 1 -> $row
  {
    print ": $row ";
    for 1 .. $cols -> $col
    {
      if @N[$col-1] >= $row
      {
        print "# ";
      }
      elsif @N-new[$col-1] >= $row
      {
        print $col-red ~ "#" ~ $col-stop ~ " ";
      }
      else
      {
	print "  ";
      }
    }
    print "\n";
  }
  say ": " ~ "-" x $cols + $cols + 2;
  say ":   ", @N.join(" "), " (before)";
  say ":   ", @N-new.join(" "), " (after)";
}