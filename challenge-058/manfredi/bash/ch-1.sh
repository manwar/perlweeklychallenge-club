#!/bin/bash
set -e

compare() {
    v1=${1//_/-}
    v2=${2//_/-}
    [[ $1 == $2  ]] && cmp="0"
    [[ $v1 > $v2 ]] && cmp="1"
    [[ $v1 < $v2 ]] && cmp="-1"
    echo $cmp
}

declare -A sig=( ['0']='=' ['1']='>' ['-1']='<')

declare -a data=(
   "0.1     1.1"
   "2.0     1.2"   
   "1.2     1.2_5"  
   "1.2.1   1.2_1"
   "1.2.1   1.2.1"
)


printf "%10s     %10s  %s\n" 'v1' 'v2' 'Result'
printf "%10s     %10s  %s\n" `printf '%.s-' $(seq 10)` `printf '%.s-' $(seq 10)` `printf '%.s-' $(seq 6)`

for i in "${data[@]}"
do
   declare -a v=($(echo "$i" | tr  -s ' ' '\n'))
   cmp=$(compare $i)
   printf "%10s  %s  %10s %5s\n"  ${v[0]} ${sig[$cmp]} ${v[1]} $cmp
done
