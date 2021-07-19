#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -A matrix

#
# Given a path, calculate its length. The path is given as
# a (single) space separated string.
#
function f_path_length () {
    local path=$1
    local l=0
    local pat="("${path// /) (}")"
    [[ $path =~ $pat ]]
    for ((i = 2; i <= ${#BASH_REMATCH[@]}; i ++))
    do  ((from = BASH_REMATCH[i - 1]))
        ((to   = BASH_REMATCH[i]))
        ((l   += matrix["$from,$to"]))
    done
    ((path_length = l))
}

function f_shortest_path () {
    local from=$1
    local to=$2
    local path=$3
    local i

    #
    # Split the path so we have the already visited vertices in nodes
    #
    local pat="("${path// /) (}")"
    [[ $path =~ $pat ]]
    local nodes=()
    for ((i = 1; i < ${#BASH_REMATCH[@]}; i ++))
    do  ((nodes[i - 1] = BASH_REMATCH[i]))
    done

    #
    # If 'path' already has all the nodes, we're done
    #
    if   ((rows == ${#nodes[@]}))
    then shortest_path=$path" "$to
         return
    fi

    #
    # Create a mapping of nodes already seen
    #
    declare -A visited
    local seen
    for ((i = 0; i < ${#nodes[@]}; i ++))
    do  ((seen = nodes[i]))
        ((visited[$seen] = 1))
    done

    #
    # Try all possibilities, keep the shortest
    #
    local shortest=9223372036854775807
    local sh_path
    local n
    local new_path
    for ((n = 0; n < rows; n ++))
    do  if   ((visited[$n] != 1))
        then f_shortest_path $n $to "$path $n"
             f_path_length "$shortest_path"
             if   ((shortest > path_length))
             then ((shortest = path_length))
                  sh_path="$shortest_path"
             fi
        fi
    done

    shortest_path=$sh_path
}

#
# Read in the matrix. Since bash lacks proper multidimensional
# arrays, we use an associative array, using "$x,$y" as key.
#
((rows = 0))
while read -a row
do    for ((c = 0; c < ${#row[@]}; c ++))
      do  ((matrix["$rows,$c"] = row[c]))
      done
      ((rows ++))
done


f_shortest_path 0 0 "0"
f_path_length "$shortest_path"

echo $path_length
echo $shortest_path
