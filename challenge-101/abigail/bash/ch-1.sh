#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

#
# Directions
#
RIGHT=0
UP=1
LEFT=2
DOWN=3

#
# Map 2-D coordinates to 1-D coordinates, as Bash doesn't
# have multidimensional arrays.
#
# The result of the function will be available in $index
#
function idx () {
    index=$(($1 * $4 + $2))
}


#
# Read in data
#
read -a elements


#
# Find optimal sizes: width $width and height $height
# Bash doesn't have sqrt, so we count upwards from 1, keeping 
# track of the largest height which evenly divides the number
# of elements -- with the condition that height <= (nr of elements) / height
#
height=1
n=${#elements[*]}
for  ((h = 2; h <= n / h; h ++))
do   if   ((!(n % h)))
     then height=$h
     fi
done
width=$((n / height))


#
# Fill in the matrix, starting from the bottom left
#
declare -a matrix
min_x=0
max_x=$((height - 1))
min_y=0
max_y=$((width - 1))
x=$max_x
y=$min_y
direction=$RIGHT

#
# Fill the matrix, starting from the bottom left
#
for ((i = 0; i < n; i ++))
do  idx $x $y $height $width
    matrix[$index]=${elements[$i]}
    turn=0
    if   ((direction == RIGHT))
    then if   ((y >= max_y))
         then turn=1; ((x --)); ((max_x --))
         else ((y ++))
         fi
    fi
    if   ((direction == UP))
    then if   ((x <= min_x))
         then turn=1; ((y --)); ((max_y --))
         else ((x --))
         fi
    fi
    if   ((direction == LEFT))
    then if   ((y <= min_y))
         then turn=1; ((x ++)); ((min_x ++))
         else ((y --))
         fi
    fi
    if   ((direction == DOWN))
    then if   ((x >= max_x))
         then turn=1; ((y ++)); ((min_y ++))
         else ((x ++))
         fi
    fi
    if   ((turn == 1))
    then ((direction ++))
         ((direction %= 4))
    fi
done


#
# Find the widths of the columns
#
declare -a widths
for  ((y = 0; y < width; y ++))
do   max=0
     for ((x = 0; x < height; x ++))
     do  idx $x $y $height $width
         element=${matrix[$index]}
         if   ((max < ${#element}))
         then max=${#element}
         fi
     done
     widths[$y]=$max
done

#
# Print out the matrix
#
for  ((x = 0; x < height; x ++))
do   for  ((y = 0; y < width; y ++))
     do   idx  $x $y $height $width
          if   ((y))
          then printf " "
          fi
          printf %${widths[$y]}s ${matrix[$index]}
     done
     echo
done

