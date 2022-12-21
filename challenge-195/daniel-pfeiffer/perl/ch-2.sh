#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}

echo See details on https://perl1liner.sourceforge.io/Challenge-and-Golf/#2022-12-18

pl -oE '$c = max values %c;
	say $c ? min grep { $c{$_} == $c } keys %c : -1' '
	$_ % 2 or ++$c{$_}' 1 1 2 6 2
pl -oE 'say min( grep { $c{$_} == $c } keys %c ) // -1' '
	$_ % 2 or $c = max $c, ++$c{$_}' 1 3 5 7
pl -oE 'say min( grep { $c{$_} == $c } keys %c ) // -1' '
	$_ % 2 or $c = max $c, ++$c{$_}' 6 4 4 6 1
