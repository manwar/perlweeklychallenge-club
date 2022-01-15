# The Weekly Challenge 147
# Task 1 Truncatable Prime
# Instructions: Print the first 20 left truncatable primes.
# Usage: $ chmod +x ch-1.sh
#        $ ./ch-1.sh

target_size=20
prime=(2 3 5 7)

i=4
for ((n=10; n<1000; n=$n+1));
do
    loop=1
    for ((k=2;k<=n/3; k=$k+1));
    do
        if [[ $n%$k -eq 0 ]];
        then
            loop=0
            break
        fi
    done
    if [[ $loop -eq 1 ]];
    then
        prime[$((i))]=$n
        i=$i+1
    fi
done

i=0
n=0
while [ $((prime[$n])) -le 996 ]  # 997 or above will return error
do
    loop=0
    k=0
    for ((k=0; $((prime[$k]))<=996; k=$k+1));
    do
        if [[ $((prime[$n]))%10 -eq $((prime[$k])) ]];
        then
            loop=$loop+1
        fi
        if [[ $((prime[$n]))%100 -eq $((prime[$k])) ]];
        then
            loop=$loop+1
        fi
    done
    if [[ $loop -eq 2 ]];
    then
        echo $((prime[$n]))
        i=$i+1
    fi
    n=$n+1
    if [[ $i -gt $target_size ]]
    then
        exit
    fi
done
