#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

#
# Parse input
#
while read start_time current_time file_name
do  time_diff=$(((current_time - start_time) * 1000))

    #
    # Read the media file, storing run times and titles
    # into two arrays.
    #
    declare -a run_times
    declare -a titles
    total_time=0

    nr_of_tracks=0
    while read track
    do    
        run_time=${track/,*/}
        title=${track/[^,]*,/}
        run_times[$nr_of_tracks]=$run_time
        titles[$nr_of_tracks]=$title
        ((nr_of_tracks ++))
        total_time=$((total_time + run_time))
    done < $file_name

    #
    # Don't care about full loops played.
    #
    time_diff=$((time_diff % total_time))

    #
    # Find the right track.
    #
    for ((i = 0; i < nr_of_tracks; i ++))
    do
        if ((time_diff - run_times[i] < 0))
        then echo ${titles[$i]}
             time_diff=$((time_diff / 1000))
             hours=$((    time_diff / 3600))
             minutes=$(( (time_diff % 3600) / 60))
             seconds=$((  time_diff         % 60))
             if ((hours > 0))
             then printf "%02d:%02d:%02d\n" $hours $minutes $seconds
             else printf      "%02d:%02d\n"        $minutes $seconds
             fi
             break
        else time_diff=$((time_diff - run_times[i]))
        fi
    done
done
