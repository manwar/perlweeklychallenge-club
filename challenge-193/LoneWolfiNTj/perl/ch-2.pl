#! /usr/bin/perl

# ======= DOCUMENTATION =======

=pod

Task 2: Odd String
Submitted by: Mohammad S Anwar

You are given a list of strings of same length, @s. Write a script
to find the odd string in the given list. Use positional value of
alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25. Find the
difference array for each string as shown in the example.
Then pick the odd one out.

Example 1:
Input:         @s = ("adc", "wzy", "abc")
Differences:   %d =
               {
                  "adc" => [ 3, -1 ],
                  "wzy" => [ 3, -1 ],
                  "abc" => [ 1, 1 ]
               }
Output:        "abc"

Example 2:
Input:         @s = ("aaa", "bob", "ccc", "ddd")
Differences:   %d =
               {
                  "aaa" => [ 0, 0 ],
                  "bob" => [ 13, -13 ],
                  "ccc" => [ 0, 0 ],
                  "ddd" => [ 0, 0 ]
               }
Output:        "bob"

=cut

# Note: Input is via built-in array of arrays of strings,
#       or via a single space-separated list of strings
#       given via command-line arguments.

# Note: Output is to stdout and will be one-or-more lists
#       of strings along with their "odd man out" if any.

# ======= PRELIMINARIES =======

use v5.36;

# Set output list separator to ', ' for printing:
$"=', ';

# ======= SUBROUTINES =======

sub differences ($s)
{
   my $aref=[];
   my $idx;
   for ( $idx = 1 ; $idx < length($s) ; ++$idx )
   {
      push @{$aref}, ord(substr $s, $idx, 1) - ord(substr $s, $idx-1, 1);
   }
   return $aref;
}

# Are two arrays of real numbers equal?
sub arrays_are_equal ($aref1, $aref2)
{
   if (scalar(@{$aref1}) != scalar(@{$aref2})) {return 0}
   for (0..$#$aref1)
   {
      if ($aref1->[$_] != $aref2->[$_])        {return 0}
   }
                                               {return 1}
}

# Report any persons who are "not of The Body" to The Lawgivers:
sub not_of_the_body (@s)
{
   say '';
   say "candidates: @s";
   my %d;
   for (@s) {$d{$_} = differences($_);}
   say 'differences:';
   for (@s)
   {
      say $_, ': ', "@{$d{$_}}";
   }

   # Examine each candidate for possible oddness:
   for ( my $i = 0 ; $i <= $#s ; ++$i )
   {
      my $oth = 1; # start by assuming others are all same
      my $sam = 1; # start by assuming I am same as others

      # Are the others REALLY all the same?
      for ( my $j = 0 ; $j <= $#s-1 ; ++$j )
      {
         next if $j == $i; # skip self
         for ( my $k = $j+1 ; $k <= $#s ; ++$k )
         {
            next if $k == $i; # skip self
            if (!arrays_are_equal($d{$s[$j]}, $d{$s[$k]}))
            {
               $oth = 0; # You are NOT of The Body!! LAWGIVERS!!!
            }
            last if !$oth;
         }
         last if !$oth;
      }

      # If the others are not the same, there is no norm to be violated.
      if (!$oth)
      {
         next;
      }

      #Am I REALLY the same as the others?
      for ( my $j = 0 ; $j <= $#s ; ++$j )
      {
         if (!arrays_are_equal($d{$s[$i]}, $d{$s[$j]}))
         {
            $sam = 0; # I am NOT of The Body!
         }
         last if !$sam;
      }

      # If I'm violating the norm, report me to The Lawgivers:
      if (!$sam)
      {
         say "$s[$i] is NOT of The Body!! LAWGIVERS!!!";
      }
   } # end for each candidate
   return;
}

# ======= MAIN BODY OF SCRIPT =======

# Default input:
my @strings =
(
   ["adc", "wzy", "abc"],
   ["aaa", "bob", "ccc", "ddd"],
);

# Non-default input:
if (scalar(@ARGV)>0) {@strings = ([@ARGV])};

say 'May the peace of Landru be with you.';

for (@strings)
{
   not_of_the_body(@{$_});
}

exit;

__END__
