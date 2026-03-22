#!/opt/homebrew/bin/bash

while read -r line
do  (( valid = 0 ))
    for token in $line
    do  
        # Remove trailing punctuation
        last=${token: -1}
        if [[ "X$last" == "X." || "X$last" == "X!" || "X$last" == "X," ]]
        then
            token=${token:0:-1}
        fi 

        # Remove a hyphen followed by a lower case letter, once
        token=${token/-[a-z]}

        # Remove all lowercase letters
        token=${token//[a-z]}

        # If empty, the token was valid
        if [[ "X$token" == "X" ]]
        then
            (( valid ++ ))
        fi
    done
    echo $valid
done
