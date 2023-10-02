#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}

echo See details on https://perl1liner.sourceforge.io/Challenge-and-Golf/#2023-08-13

pl -oB 'sub c { all { 1 == uniq @$_ } zip \@a, \@_ }' '
    @s = sort @a = split //; c @s or c reverse @s or ++$RESULT' abc bce cae
pl -oB 'sub c { all { 1 == uniq @$_ } zip \@a, \@_ }' '
    @s = sort @a = split //; c @s or c reverse @s or ++$RESULT' yxz cba mon
