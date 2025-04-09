#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 1,
	       :c(:$circular),
               :v(:$verbose));

my $ok;

@list.push: @list[0] if $circular;


for 1 .. @list.end -> $index
{
  $ok = @list[$index -1].substr(@list[$index -1].chars -1) eq @list[$index].substr(0,1);

  say ": '@list[$index -1]' <=> '@list[$index]' { $ok ?? 'OK' !! '' }" if $verbose;

  last unless $ok;
}

say $ok;
