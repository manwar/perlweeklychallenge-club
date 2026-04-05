#!/opt/homebrew/bin/bash

#
# Get two times in HH:MM format, return -1 if the first time is before
# the second time; return 1 if the second time is before the first time;
# return 0 if the times are equal.
#
function tcmp () {
    t1=(${1/:/ })   # Turn HH:MM into an array ["HH", "MM"]
    t2=(${2/:/ })
    if [[ ${t1[0]} < ${t2[0]} ]]; then echo -1; return; fi
    if [[ ${t1[0]} > ${t2[0]} ]]; then echo  1; return; fi
    if [[ ${t1[1]} < ${t2[1]} ]]; then echo -1; return; fi
    if [[ ${t1[1]} > ${t2[1]} ]]; then echo  1; return; fi
    echo 0
}


while read b1 e1 b2 e2
do  if [[ $(tcmp $b1 $e1) > 0 ]]; then straddle1=1; else straddle1=0; fi
    if [[ $(tcmp $b2 $e2) > 0 ]]; then straddle2=1; else straddle2=0; fi
    if [[ $straddle1 == 1 && $straddle2 == 1 ]]
    then echo "true"
         continue
    fi

    if [[ $straddle1 == 1 ]]
    then if [[ $(tcmp $b1 $e2) -ge 0 && $(tcmp $e1 $b2) -le 0 ]]
         then echo "false"
         else echo "true"
         fi
         continue
    fi

    if [[ $straddle2 == 1 ]]
    then if [[ $(tcmp $b2 $e1) -ge 0 && $(tcmp $e2 $b1) -le 0 ]]
         then echo "false"
         else echo "true"
         fi
         continue
    fi

    if [[ $(tcmp $e2 $b1) -le 0 || $(tcmp $b2 $e1) -ge 0 ]]
    then echo "false"
    else echo "true"
    fi

done
