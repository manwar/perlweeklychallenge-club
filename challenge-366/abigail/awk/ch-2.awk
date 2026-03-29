#!/opt/homebrew/bin/gawk

BEGIN {
    FS=":"
}

#
# Loop over each line of input
#
{
    hours   = $1;
    minutes = $2;

    h_times =        hours   == "??"           ?  24   \
            : match (hours,    /^\?[0-3]$/)    ?   3   \
            : match (hours,    /^\?[4-9]$/)    ?   2   \
            : match (hours,    /^[01]\?$/)     ?  10   \
            :        hours   == "2?"           ?   4   \
            : match (hours,    /^[01][0-9]$/)  ?   1   \
            : match (hours,    /^2[0-3]$/ )    ?   1   \
            :                                      0

    m_times =        minutes == "??"           ?  60   \
            : match (minutes,  /\?[0-9]$/)     ?   6   \
            : match (minutes,  /^[0-5]\?$/)    ?  10   \
            : match (minutes,  /^[0-5][0-9]$/) ?   1   \
            :                                      0

    print h_times * m_times
}
