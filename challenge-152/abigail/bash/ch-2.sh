#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

while read a_x1 a_y1 a_x2 a_y2 b_x1 b_y1 b_x2 b_y2
do 
      ((a_x_min   =  a_x1 < a_x2 ? a_x1 : a_x2))
      ((a_x_max   =  a_x1 < a_x2 ? a_x2 : a_x1))
      ((a_y_min   =  a_y1 < a_y2 ? a_y1 : a_y2))
      ((a_y_max   =  a_y1 < a_y2 ? a_y2 : a_y1))
      ((b_x_min   =  b_x1 < b_x2 ? b_x1 : b_x2))
      ((b_x_max   =  b_x1 < b_x2 ? b_x2 : b_x1))
      ((b_y_min   =  b_y1 < b_y2 ? b_y1 : b_y2))
      ((b_y_max   =  b_y1 < b_y2 ? b_y2 : b_y1))

      ((a_area    = (a_x_max - a_x_min) * (a_y_max - a_y_min)))
      ((b_area    = (b_x_max - b_x_min) * (b_y_max - b_y_min)))

      ((x_overlap = (a_x_max < b_x_max ? a_x_max : b_x_max) -
                    (a_x_min < b_x_min ? b_x_min : a_x_min)))
      ((y_overlap = (a_y_max < b_y_max ? a_y_max : b_y_max) -
                    (a_y_min < b_y_min ? b_y_min : a_y_min)))

      ((overlap   = (x_overlap < 0 ? 0 : x_overlap) *
                    (y_overlap < 0 ? 0 : y_overlap)))

      echo $((a_area + b_area - overlap))
done
