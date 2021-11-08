#!/usr/bin/env raku
use v6;

# comparing stuff might be tricky with computer representation of numbers
my \tolerance = 1e-7;

# a tiny class for handling a limited set of vector operations
class Vector {
   has @.cs is built is required;

   # "dot", i.e. scalar, product
   method dot (Vector $a) { return [+](self.cs »*« $a.cs) }

   # the *square* of the length is all we need in our solution
   method length_2 ()     { return self.dot(self) }
}

# difference between vectors, uses stock constructor from Vector
multi sub infix:<->(Vector $a, Vector $b) {
   Vector.new(cs => [$a.cs »-« $b.cs]);
}

# eye candy for invoking the scalar ("dot") product
multi sub infix:<*>(Vector $a, Vector $b) { $a.dot($b) }

# check if a sequence of points represents a sequence of consecutive
# vertices of a square.
#
# Consecutive pairs define the candidate square's sides. Consecutive
# candidate square sides MUST be:
# - same length (or same length squared, which is equivalent)
# - orthogonal to each other (scalar product is zero)
sub is-sequence-a-square (@points is copy) {

   # comparing candidate sides means that we consider a "previous" side
   # and a "current" one. A side is defined as the vector resulting from
   # the difference of two consecutive points.
   my $previous = @points[1] - @points[0];

   # we just need to compare 3 sides, if they comply then the 4th will too
   for 1, 2 -> $i {
      my $current = @points[$i + 1] - @points[$i];

      # check if sides have the same length (squared)
      return False if $previous.length_2 != $current.length_2;

      # approximation might give surprises, we'll accept as orthogonal
      # sides whose scalar product is below our tolerance
      return False if $previous * $current > tolerance;

      # prepare for next iteration
      $previous = $current;
   }

   # three sides are compliant, it's a square!
   return True;
}

# check if a bunch of points form a square. They can be in any order.
sub is-square (*@points) {

   # try out permutations of the inputs that can yield a square. We fix
   # point #0 and only consider one permutation for each of the other
   # points as the opposite, ignoring the other because symmetric.
   state @permutations = (
      [0, 2, 1, 3],  # 0 and 1 are opposite
      [0, 1, 2, 3],  # 0 and 2 are opposite
      [0, 2, 3, 1],  # 0 and 3 are opposite
   );
   for @permutations -> $permutation {
      my @arrangement = @points[@$permutation].map({Vector.new(cs => @$_)});
      return 1 if is-sequence-a-square(@arrangement);
   }
   return 0;
}

say is-square($(10, 20), $(20, 20), $(20, 10), $(10, 10));
say is-square($(12, 24), $(16, 10), $(20, 12), $(18, 16));
say is-square($(0, 0), $(1, 1), $(0, 2), $(-1, 1));
