#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems >= 1 && @list.all ~~ Int && @list.all > 0, :v(:$verbose));

my %result = @list>>.Int.sort.classify({ $_ %% 2 ?? 'even' !! 'odd' });

say ":Classify: { %result.raku }" if $verbose;

my @result;
@result =       | %result<even> if %result<even>;
@result.append: | %result<odd>  if %result<odd>;

say "(" ~ @result.join(",") ~ ")";
