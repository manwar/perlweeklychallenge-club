#! /usr/bin/env raku

use JSON::Fast;

unit sub MAIN ($file = "example1.txt", :j(:$json), :v(:$verbose));

my %hash;
my $text;

for (slurp $file).lines -> $line
{
  if $line ~~ /^\{\%(.*)\%\}$/ && ! %hash<name>
  {
    my $data    = $0.Str;
    my @data    = do-parse($data);
    %hash<name> = @data.shift;

    my %fields;
    for @data -> $data
    {
      my ($k,$v)  = $data.split('=');
      %fields{$k} = $v;
    }

    %hash<fields> = %fields;
  }
  elsif $line eq '{% end' ~ %hash<name> ~ ' %}'
  {
    %hash<text> = $text if $text;
    last;
  }
  elsif %hash<name>
  {
    $text ~= "$line\n";
  }
  else
  {
    die "Illegal data in input: $line";
  }
}

say $json
  ?? to-json %hash, :sorted-keys
  !! %hash.raku;

sub do-parse ($string)
{
  my @done;
  my $todo = $string.trim;

  while $todo
  {
    $todo ~~ /^ \s* (\w+)(.*)/;
    my $key = $0.Str;
    my $val = "";
    $todo   = $1.Str;

    if $todo.starts-with('="')
    {
      $todo ~~ /^\=\"(.*)/;

      my @todo = $0.Str.comb;

      while @todo
      {
        my $char = @todo.shift;
	$char ~= @todo.shift if $char eq "\\";
	$val ~= $char;
        if @todo[0] eq '"'
	{
	  $todo = @todo[1..*].join;
	  last;
	}
      }

      # $val = $0.Str;
      # $todo   = $1.Str;
      @done.push: "$key=$val";     
    }
    elsif $todo.starts-with('=')
    {
      # say "=";
      $todo ~~ /^\=(<[0..9.]>+)(.*)/;
      $val    = $0.Str;
      $todo   = $1.Str;
      @done.push: "$key=$val";
    }
    else
    {
      # say "name only";
      @done.push: $key;
    }
  }

  say ": Parsed: { @done.raku }" if $verbose;
  return @done;
}