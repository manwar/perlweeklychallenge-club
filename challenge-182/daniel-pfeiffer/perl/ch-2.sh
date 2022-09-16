#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}


echo "Loop over @ARGV with -o and initialize with -B for BEGIN handling.
Use pl's" '$R & $I (aliased to $RESULT & $ARGIND)'

pl -oB '$x = -INF' '$x = $_, $R = $I if $x < $_' 5 2 9 1 7 6
pl -oB '$x = -INF' '$x = $_, $RESULT = $ARGIND if $x < $_' 4 2 3 1 5 0

echo Same, setting @ARGV Perl-style with -A instead

pl -oA '$x = -INF; (5, 2, 9, 1, 7, 6)' '$x = $_, $R = $I if $x < $_'
pl -oA '$x = -INF; (4, 2, 3, 1, 5, 0)' '$x = $_, $R = $I if $x < $_'


echo
echo "Use pl's" '$R (aliased to $RESULT) as an accumulator (decumulator?)'

pl -n '($R) = "$_$R" =~ /\A(.*\/).*(\n\1|\Z)/' <<EOF
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
EOF

echo Same, looping over @ARGV with -o instead

pl -o '($R) = "$_\n$R" =~ /\A(.*\/).*(\n\1|\Z)/' /a/b/c/1/x.pl /a/b/c/d/e/2/x.pl /a/b/c/d/3/x.pl /a/b/c/4/x.pl /a/b/c/d/5/x.pl

echo Use -E for END handling to cleanup trailing / as per the task

pl -nE '$R =~ s!.\K/$!!' '($R) = "$_$R" =~ /\A(.*\/).*(\n\1|\Z)/' <<EOF
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
EOF

echo Same, test that it leaves at least initial /

pl -nE '$R =~ s!.\K/$!!' '($R) = "$_$R" =~ /\A(.*\/).*(\n\1|\Z)/' <<EOF
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
/x
EOF

echo Same, test that it works without initial /

pl -nE '$R =~ s!.\K/$!!' '($R) = "$_$R" =~ /\A(.*\/).*(\n\1|\Z)/' <<EOF
a/b/c/1/x.pl
a/b/c/d/e/2/x.pl
a/b/c/d/3/x.pl
a/b/c/4/x.pl
a/b/c/d/5/x.pl
EOF

echo Same, add safety guard to not start over after failure

pl -nE '$R =~ s!.\K/$!!' '($R) = "$_$R" =~ /\A(.*\/).*(\n\1|\Z)/; $R // exit' <<EOF
a/b/c/1/x.pl
a/b/c/d/e/2/x.pl
a/b/c/d/3/x.pl
a/b/c/4/x.pl
x
a/b/c/d/5/x.pl
EOF
