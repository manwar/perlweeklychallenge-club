#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}

echo See details on https://perl1liner.sourceforge.io/Challenge-and-Golf/#2022-12-18

pl -oA '1..15' '/(.).*\1/ or ++$RESULT'
pl -oA '1..35' '/(.).*\1/ or ++$RESULT'
