#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[01\?]>+ $/,
               :v(:$verbose));

my @todo = $str;
my @ok;

while @todo
{
  my $current = @todo.shift;
  my $pos     = $current.index('?');

  if defined $pos
  {
    for '0', '1' -> $digit
    {
      $current.substr-rw($pos, 1) = $digit;
      @todo.push: $current;
      say ":Added $current to todo list" if $verbose;
    }
  }
  else
  {
    @ok.push: $current;
  }
}

say "(" ~ @ok.map( '"' ~ *  ~ '"' ).join(", ") ~ ")";
