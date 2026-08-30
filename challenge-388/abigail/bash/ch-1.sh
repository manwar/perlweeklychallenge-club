#!/opt/homebrew/bin/bash

function process () {
    local n=$1
    local u=$2
    local d=$3
    local prefix=$4
    if   ((d == n))
    then printf "${prefix} "
    fi
    if   ((d < u))
    then process $n $u $((d + 1)) "${prefix}D"
    fi
    if   ((u < n))
    then process $n $((u + 1)) $d "${prefix}U"
    fi
}

while read n
do    process $n 0 0 ""
      echo
done
