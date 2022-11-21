#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}

echo See details on https://perl1liner.sourceforge.io/Perl-Weekly-Challenge/#2022-11-20

# limit to 10, as then it gets slower, from 13 very slow
for i in 1 2 3 4 5 6 7 8 9 10; do
    echo -n "$i: "
    pl -MAlgorithm::Permute=permute -A '1..'$i 'permute {
	max(@l = ($_, $ARGV[$_ - 1])) % min(@l) ? last : ($_ == @ARGV && ++$RESULT) for 1..@ARGV
    } @ARGV'
done
