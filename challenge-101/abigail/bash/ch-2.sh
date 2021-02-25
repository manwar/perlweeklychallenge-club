#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

#
# See https://stackoverflow.com/questions/2049582/
#

#
# This determines on which side of the line through ($x1, $y1) and
# ($x2, $y2) the origin lies. If > 0, then the origin lies to the left
# of the line, if < 0, the origin lies to the right of the line, if
# = 0, the origin lies on the line.
#
function calc_side () {
    #
    # $1: x1; $2: y1; $3 = x2; $4 = y2
    #
    side=$((($4 - $2) * $3 - ($3 - $1) * $4))
}


while read x1 y1 x2 y2 x3 y3
do    #
      # Determine where the origin is relative to the three lines 
      # through the vertices of the triangle. Note we have to go
      # in a specific order through the points. (Either clock wise,
      # or counter clockwise, as long as we're consistent).
      #
      calc_side x2 y2 x3 y3; s1=$side
      calc_side x3 y3 x1 y1; s2=$side
      calc_side x1 y1 x2 y2; s3=$side

      #
      # If the origin either lies to the left (or on) each of the
      # lines, or to the right (or on) each of the lines, the origin
      # lies inside the triangle. If not, it does not.
      #
      echo $(( $s1 <= 0 && $s2 <= 0 && $s3 <= 0 ||
               $s1 >= 0 && $s2 >= 0 && $s3 >= 0 ? 1 : 0 ))
done
