#!/opt/homebrew/bin/bash

ord_a=97

while read -r line
do  for ((i = 26; i > 0; i --)) #
                                # We're counting down from 26 to 1, so we're
                                # not incorrectly converting the single digits
                                # from double digit numbers
                                #
    do  #
        # Get the replacement character in $ch. We need a detour by first
        # creating a hex unicode escape, which we then convert into a 
        # character. So 1 gets mapped to 'a', 2 to 'b', etc.
        #
        printf -v esc "U+%02x" $((i + ord_a - 1))
        printf -v ch  ${esc/U+/"\U"}

        #
        # We either replace a single digit number, or a double digit
        # number followed by a #
        #
        pat=$i
        if ((i >= 10))
        then pat="$pat#"
        fi

        #
        # Do the replacement, globally
        #
        line=${line//$pat/$ch}
    done
    echo $line
done
