#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

declare -A nodes
declare -A graph

while read -a strings
do    nodes=()
      graph=()
      #
      # Read in the strings. Build a graph where the first and last
      # characters of the strings are the nodes, and for each string
      # we have a directed edge from the first character to its last.
      #
      for   string in ${strings[@]}
      do    first=${string:0:1}
            last=${string:$((${#string}-1)):1}
            nodes[$first]=1
            nodes[$last]=1
            graph[$first$last]=1
      done

      #
      # Calculate the transitive closure using the Floyd-Warshall algorithm.
      #
      for   k in ${!nodes[@]}
      do    for i in ${!nodes[@]}
            do    for   j in ${!nodes[@]}
                  do    if [ X${graph[$k$j]} == X1 -a \
                             X${graph[$i$k]} == X1 ]
                        then graph[$i$j]=1
                        fi
                  done
            done
      done

      #
      # There's a cycle iff there's a node which is reachable from itself.
      #
      out=0
      for   i in ${!nodes[@]}
      do    if   [ X${graph[$i$i]} == X1 ]
            then out=1
            fi
      done

      echo $out
done
