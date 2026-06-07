#! /usr/bin/env raku

unit sub MAIN ($str is copy, :v(:$verbose));

class mushroom
{
  has $.word    is required;
  has $.pre           = "";
  has $.post          = "";
  has $.doubled is rw = False;

  method insensitive
  {
    return $.word.lc;
  }

  method double
  {
    $.doubled = True;
  }

  method Str
  {
    my $output = "";
    $output ~= $.pre  if $.pre;
    $output ~= "["    if $.doubled;
    $output ~= $.word;
    $output ~= "]"    if $.doubled;
    $output ~= $.post if $.post;
    return $output;
  }
}

$str ~~ s:g/\\n/\n/;

my @lines = $str.lines;

my $last_line_token;

my @output-rows;

for @lines -> $line
{
  say ": Line: $line" if $verbose;

  my @chunks = $line.words;
  my @a;
  my $t;
  
  for @chunks -> $chunk is copy
  {
    my $pre  = "";
    my $post = "";

    while $chunk ~~ /^ (<['"(]>) (.*) /
    {
      $pre ~= $0.Str; $chunk = $1.Str;
    }

    while $chunk ~~ /^ ("<" <[a..z A..Z]> ">") (.*) /
    {
      $pre ~= $0.Str; $chunk = $1.Str;
    }
    
    while $chunk ~~ / (.*) (<[,.;:!)'"]>) $/
    {
      $post = $1.Str ~ $post; $chunk = $0.Str;
    }

    while $chunk ~~ / (.*) ("<" "/" <[a..z A..Z]> ">") $/
    {
      $post = $1.Str ~ $post; $chunk = $0.Str;
    }

    $t = mushroom.new( word => $chunk, pre => $pre, post => $post );

    if @a.elems && @a[*-1].insensitive eq $t.insensitive
    {
      @a[*-1].double;
      $t.double;
    }

    @a.push: $t;
  }

  if $last_line_token && $last_line_token eq @a[0].insensitive
  {
    say ": - doubled the last chunk on the previous line" if $verbose;
    @a[0].double;
    @output-rows[*-1].[*-1].double;
  }

  $last_line_token = $t.insensitive;

  say ": Content: { @a.raku }" if $verbose;

  @output-rows.push: @a;
}

for @output-rows -> @row
{
  say @row.join(" ") if any @row>>.doubled;
}
