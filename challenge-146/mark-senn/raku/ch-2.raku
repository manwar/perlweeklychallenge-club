my $member = $*IN.get;

# Split into numerator and denominator.
my ($n, $d) = $member.split('/');

say "Input: \$member = '$n/$d'";

for ('Output: parent =', ' and grandparent =') -> $label
{
    if    ($n < $d)  { $d = $d - $n;            }
    elsif ($n == $d) { say "no parent"; exit 1; }
    else             { $n = $n - $d;            }
    print "$lable '$n/$d'";
}

say '';
