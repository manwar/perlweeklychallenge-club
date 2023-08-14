#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}

echo See details on https://perl1liner.sourceforge.io/Challenge-and-Golf/#2023-08-13

pl -oE Number '++$NUMBER{$_} for uniq eval'  '1, 1, 2, 4'  '2, 4'  4
pl -oE Number '++$NUMBER{$_} for uniq eval'  '4, 1'  '2, 4'  '1, 2'
