#! /usr/bin/env raku

unit sub MAIN ($word where $word.chars > 1,
               *@list where @list.elems > 1,
	       :i(:$case-insensitive),
               :v(:$verbose));

my $acronym = @list>>.substr(0,1).join;

say ": Acronym: $acronym" if $verbose;

say $case-insensitive
  ?? $acronym.lc eq $word.lc
  !! $acronym eq $word;

