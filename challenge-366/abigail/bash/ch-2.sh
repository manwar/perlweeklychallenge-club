#!/opt/homebrew/bin/bash

IFS=":"

while read hours minutes
do  ((h_times = 0))
    ((m_times = 0))

    #
    # Process the hours, calculate how many options it gives
    #
    if   [[ $hours   =~ ^\?\?$       ]]
    then (( h_times  =   24 ))
    elif [[ $hours   =~ ^\?[0-3]$    ]]
    then (( h_times  =    3 ))
    elif [[ $hours   =~ ^\?[4-9]$    ]]
    then (( h_times  =    2 ))
    elif [[ $hours   =~ [01]\?$      ]]
    then (( h_times  =   10 ))
    elif [[ $hours   =~ ^2\?$        ]]
    then (( h_times  =    4 ))
    elif [[ $hours   =~ ^[01][0-9]$  ]]
    then (( h_times  =    1 ))
    elif [[ $hours   =~ ^2[0-3]$     ]]
    then (( h_times  =    1 ))
    fi

    #
    # Process the minutes, calculate how many options it gives
    #
    if   [[ $minutes =~ ^\?\?$       ]]
    then (( m_times  =   60 ))
    elif [[ $minutes =~ ^\?[0-9]$    ]]
    then (( m_times  =    6 ))
    elif [[ $minutes =~ ^[0-5]\?$    ]]
    then (( m_times  =   10 ))
    elif [[ $minutes =~ ^[0-5][0-9]$ ]]
    then (( m_times  =    1 ))
    fi

    echo $(( $h_times * $m_times ))

done
