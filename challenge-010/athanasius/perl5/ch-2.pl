use strict;
use warnings;
use Const::Fast;

const my $CASE_SENSITIVE => 0;
const my @DEFAULT        => qw( DwAyNE DuANE );
const my $PREFIX_SIZE    => 4;
const my $PREFIX_SCALE   => 0.1;
const my $SEEN           => 034;

$| = 1;

MAIN:
{
    my $s1    = $ARGV[0] // $DEFAULT[0];
    my $s2    = $ARGV[1] // $DEFAULT[1];
    my $sim_j = sim_j($s1, $s2);
    my $sim_w = sim_w($s1, $s2);
    my $dst_w = dst_w($s1, $s2);

    printf "\nBetween the strings '%s' and '%s':\n"  .
             "    the Jaro         similarity is %f\n" .
             "    the Jaro-Winkler similarity is %f\n" .
             "    the Jaro-Winkler distance   is %f\n",
             $s1, $s2, $sim_j, $sim_w, $dst_w;
}

sub dst_w
{
    my ($s1, $s2) = @_;

    my $sim_w = sim_w($s1, $s2);

    return (1 - $sim_w);
}

sub sim_w
{
    my ($s1, $s2) = @_;

    my $sim_j = sim_j($s1, $s2);
    my $len   = 0;

    for my $i (0 .. $PREFIX_SIZE - 1)       # Calculate the prefix length
    {
        last if $i >= length $s1 ||
                $i >= length $s2 ||
                substr($s1, $i, 1) ne substr($s2, $i, 1);
        ++$len;
    }

    return $sim_j + ($len * $PREFIX_SCALE * (1 - $sim_j));
}

sub sim_j
{
    my ($s1, $s2) = @_;

    my ($m, $m1, $m2) = matches($s1, $s2);

    return 0 if $m == 0;

    my $t = trans($m1, $m2);

    return (($m / length($s1)) + ($m / length($s2)) + (($m - $t) / $m)) / 3;
}

sub matches
{
    my ($s1, $s2) = @_;

    my $len1 = length $s1;
    my $len2 = length $s2;
    my $maxl = $len1 >= $len2 ? $len1 : $len2;
    my $maxd = int($maxl / 2) - 1;
    my @a1   = split //, $CASE_SENSITIVE ? $s1 : uc $s1;
    my @a2   = split //, $CASE_SENSITIVE ? $s2 : uc $s2;
    my $m    = 0;

    # First match characters which are in the same position in the 2 strings,
    # then match the remaining (i.e., unmatched) characters which differ by
    # exactly 1 position, then match the remaining characters which differ by
    # exactly 2 positions, and so on to the maximum allowed distance

    for my $dist (0 .. $maxd)
    {
        for my $i (0 .. $#a1)
        {
            next if $a1[$i] eq $SEEN;

            for my $j ($i - $dist .. $i + $dist)
            {
                next if $j < 0 || $j > $#a2 || $a2[$j] eq $SEEN;

                if ($a1[$i] eq $a2[$j])
                {
                    ++$m;
                    $a1[$i] = $SEEN;
                    $a2[$j] = $SEEN;
                    last;
                }
            }
        }
    }

    # Form arrays of matched characters, retaining original sequence

    my (@m1, @m2);
    $a1[$_] eq $SEEN && push @m1, substr($s1, $_, 1) for 0 .. $#a1;
    $a2[$_] eq $SEEN && push @m2, substr($s2, $_, 1) for 0 .. $#a2;

    return ($m, \@m1, \@m2);
}

sub trans
{
    my ($m1, $m2) = @_;     # Matched-character arrays
    my  $t        = 0;

    # Note: This implements a literal reading of the Wikipedia description:
    #    "The number of matching (but different sequence order) characters
    #     divided by 2 defines the number of transpositions."

    for my $i (0 .. $#$m1)
    {
        ++$t if $m1->[$i] ne $m2->[$i];
    }

    return $t / 2;
}
