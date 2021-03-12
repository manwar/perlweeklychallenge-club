#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-2.py < input-file
#

#
# We're reading a start time, the current time, and a file name
# from STDIN, separated by white space. The file contains the
# tracks played.
#

import fileinput

for line in fileinput . input ():
    start_time, current_time, file_name = line . split ()

    #
    # You need a 64 bit integer for this; 32 bits of holds
    # a five week vacation in milliseconds, but the author 
    # of the puzzle lives somewhere were people take 14 week
    # holidays...
    #
    time_diff = (int (current_time) - int (start_time)) * 1000

    #
    # Parse the media file; store the track into an array tracks.
    #
    tracks = []
    total_time = 0
    for track in open (file_name, "r"):
        play_time, title = track . strip () . split (",", 2)
        play_time = int (play_time)
        tracks . append ([play_time, title])
        total_time = total_time + play_time

    #
    # We're not interested in playing full loops.
    #
    time_diff = time_diff % total_time

    #
    # Find the current track playing. If $time_diff is less than the
    # play time of the track, this is the track currently playing. If
    # so, print the track name (with quotes, as given in the example --
    # although they don't belong there, as they're from the CSV encoding;
    # for that reason, we won't deescape anything else either). Otherwise
    # (track length is shorter than $time_diff), we subtrack the length
    # of the track from $time_diff, and continue checking the next track.
    #
    for track in tracks:
        if time_diff - track [0] < 0:
            time_diff = int  (time_diff / 1000)
            hours     = int  (time_diff / 3600)
            minutes   = int ((time_diff % 3600) / 60)
            seconds   =       time_diff         % 60

            if hours > 0:
                format_str = "{0}\n{1:02d}:{2:02d}:{3:02d}"
            else:
                format_str = "{0}\n{2:02d}:{3:02d}"

            print (format_str . format (track [1], hours, minutes, seconds))
            break
        else:
            time_diff = time_diff - track [0]

