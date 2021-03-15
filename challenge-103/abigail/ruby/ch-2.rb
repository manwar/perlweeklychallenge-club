#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

#
# We're reading a start time, the current time, and a file name
# from STDIN, separated by white space. The file contains the
# tracks played.
#

ARGF . each_line do |_|
    start_time, end_time, file_name = _ . split

    #
    # Ruby automatically creates big integers if necessary.
    #
    time_diff = (end_time . to_i - start_time . to_i) * 1000

    tracks = []
    total_time = 0
    File . open (file_name) do |f|
        f . each_line do |track|
            run_time, title = track . split ',', 2
            run_time = run_time . to_i
            total_time += run_time
            tracks . push [run_time, title]
        end
    end

    #
    # We're not interested in playing full loops.
    #
    time_diff %= total_time

    #
    # Find the current track playing. If $time_diff is less than the
    # play time of the track, this is the track currently playing. If
    # so, print the track name (with quotes, as given in the example --
    # although they don't belong there, as they're from the CSV encoding;
    # for that reason, we won't deescape anything else either). Otherwise
    # (track length is shorter than $time_diff), we subtrack the length
    # of the track from $time_diff, and continue checking the next track.
    #
    tracks . each do |track|
        if time_diff - track [0] < 0
            time_diff =  (time_diff / 1000)       . to_i
            hours     =  (time_diff / 3600)       . to_i
            minutes   = ((time_diff % 3600) / 60) . to_i
            seconds   =   time_diff         % 60
            puts (track [1])
            if hours > 0
                puts "%02d:%02d:%02d" % [hours, minutes, seconds]
            else
                puts      "%02d:%02d" % [       minutes, seconds]
            end
            break
        else
            time_diff -= track [0]
        end
    end
end
