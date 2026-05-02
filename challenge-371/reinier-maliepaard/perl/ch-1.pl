#!/usr/bin/perl
use strict;
use warnings;
The Challenge Week #370 is an IQ‑style sequence puzzle, where the goal
is to spot a simple, plausible pattern under uncertainty, not derive a
single 'correct' mathematical law.

For each sequence, it follows four steps that mirror how humans read
short patterns:

- Compute differences between neighboring elements
  Look at the gaps: how much each term changes from the one before it.

- Look for a repeating jump pattern
  Check whether the differences follow a simple rhythm, such as
  +1, +2, +1, +2 or similar.

- Fill the missing value using that rhythm
  Extend the pattern just enough to complete the sequence.

- Reconstruct the full sequence
  Show the whole series with the gap filled, so the logic is clear and
  easy to follow.

For short, human‑scale sequences (like 5 elements), this local, procedural
logic is both effective and intuitive. It matches how people scan patterns
step‑by‑step, not by starting with a formal rule.

My solution is inspired by this.

A. Defining the Sequence
We consider a zero-based array @arr with 5 ordered elements:
arr[0], arr[1], arr[2], arr[3], arr[4]

d1 = arr[1] − arr[0]
d2 = arr[2] − arr[1]
d3 = arr[3] − arr[2]
d4 = arr[4] − arr[3]

B. Structural Rule: Repeating Two-Step Pattern
We assume the following structural rule: d1 = d3, d2 = d4
This defines a repeating two-step pattern: d1​, d2, d1, d2

The constant step strategy (d1 = d2 = d3 = d4) is a special case of this
model, where d1 = d2.
    ​
Thus:

If d1 ≠ d2 -> true alternating pattern
If d1 = d2 -> constant step sequence

C. Handling the Missing Value
One element is missing and represented by ? at position q_pos:

? a b c d (q_pos = 0)
a ? b c d (q_pos = 1)
a b ? c d (q_pos = 2)
a b c ? d (q_pos = 3)
a b c d ? (q_pos = 4)

The missing value is reconstructed using:

- the step definitions (d1, d2, d3, d4)
- the constraints (d1 = d3, d2 = d4)
    ​
Even if a direct step (e.g. d1) is not computable due to the missing
value, it can always be replaced by its equivalent:

- d1 by d3 and vice versa
- d2 by d4 and vice versa
    ​
D. Solving for Each Position
Using the equivalences, the missing value can be derived as follows:

if q_pos = 0: arr[0] = arr[1] − d3
if q_pos = 1: arr[1] = arr[2] − d4
if q_pos = 2: arr[2] = arr[3] − d1
if q_pos = 3: arr[3] = arr[4] − d2
if q_pos = 4: arr[4] = arr[3] + d2

E. Conclusion
Further improvement isn't about fixing bugs - it's already conceptually
correct and effective for the task, though still procedural and not
easily generalizable. There's still a lot that could be refined,
but I'll leave that to you :-)

# Code

sub n { ord($_[0]) - 96 } # a -> 1
sub c { chr($_[0] + 96) } # 1 -> a

sub missing_letter {
    my (@arr) = @_;

    die "Exactly 5 elements required\n" unless @arr == 5;

    my $q_count = 0;
    for (@arr) {
        if ($_ eq '?') {
            $q_count++;
        }
        elsif (!/^[a-z]$/) {
            die "Invalid input '$_' (only a-z or ? allowed)\n";
        }
    }
    die "Exactly one '?' required\n" unless $q_count == 1;

    # Convert to numbers (keep '?' as-is)
    @arr = map { $_ eq '?' ? '?' : n($_) } @arr;

    # Find position of '?'
    my ($q_pos) = grep { $arr[$_] eq '?' } 0..$#arr;

    # Steps
    # Compute differences between consecutive elements (undef if either is missing)
    my $d1 = ($arr[0] eq '?' || $arr[1] eq '?') ? undef : $arr[1] - $arr[0];
    my $d2 = ($arr[1] eq '?' || $arr[2] eq '?') ? undef : $arr[2] - $arr[1];
    my $d3 = ($arr[2] eq '?' || $arr[3] eq '?') ? undef : $arr[3] - $arr[2];
    my $d4 = ($arr[3] eq '?' || $arr[4] eq '?') ? undef : $arr[4] - $arr[3];

    # Ensure consistency: d1 == d3 and d2 == d4
    die "Inconsistent sequence: d1 != d3\n" if defined $d1 && defined $d3 && $d1 != $d3;
    die "Inconsistent sequence: d2 != d4\n" if defined $d2 && defined $d4 && $d2 != $d4;

    # Unify steps: use defined values to fill in missing ones
    $d1 //= $d3; # If $d1 is defined, keep it.
                 # Otherwise, initialize it from $d3.
    $d2 //= $d4; # If $d2 is defined, keep it.
                 # Otherwise, initialize it from $d4.

    # Reconstruct
    my $missing;

    if ($q_pos == 0) {
        $missing = $arr[1] - $d1;
    }
    elsif ($q_pos == 1) {
        $missing = $arr[2] - $d2;
    }
    elsif ($q_pos == 2) {
        $missing = $arr[3] - $d1;
    }
    elsif ($q_pos == 3) {
        $missing = $arr[4] - $d2;
    }
    elsif ($q_pos == 4) {
        $missing = $arr[3] + $d2;
    }

    # Return only the missing value as a letter
    return c($missing);
}

# Tests

# Example 1
print missing_letter(qw(a c ? g i)), "\n"; # e

# Example 2
print missing_letter(qw(a d ? j m)), "\n"; # g

# Example 3
print missing_letter(qw(a e ? m q)), "\n"; # i

# Example 4
print missing_letter(qw(a c f ? k)), "\n"; # h

# Example 5
print missing_letter(qw(b e g ? l)), "\n"; # j
