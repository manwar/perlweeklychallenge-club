#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: gawk -f ch-2.gawk < input-file
#

#
# We're reading a start time, the current time, and a file name
# from STDIN, separated by white space. The file contains the
# tracks played.
#
{
    start_time   = $1
    current_time = $2
    file_name    = $3

    time_diff = (current_time - start_time) * 1000

    nr_of_tracks = 1
    total_time = 0
    while ((getline track < file_name > 0)) {
        #
        # AWK doesn't have the ability to limit the number of
        # fields a string is split into, so we use index() and
        # substring() instead of split() to get the info.
        #
        j        = index  (track, ",")
        run_time = substr (track, 1, j - 1)
        title    = substr (track, j + 1)
        tracks [nr_of_tracks, 0] = run_time
        tracks [nr_of_tracks, 1] = title
        nr_of_tracks ++

        total_time += run_time
    }

    #
    # We're not interested in playing full loops.
    #
    time_diff %= total_time

    #
    # Find the current track playing. If time_diff is less than the
    # play time of the track, this is the track currently playing. If
    # so, print the track name (with quotes, as given in the example --
    # although they don't belong there, as they're from the CSV encoding;
    # for that reason, we won't deescape anything else either). Otherwise
    # (track length is shorter than time_diff), we subtrack the length
    # of the track from time_diff, and continue checking the next track.
    #
    for (i = 1; i <= nr_of_tracks; i ++) {
        if (time_diff - tracks [i, 0] < 0) {
            time_diff = int  (time_diff / 1000)
            hours     = int  (time_diff / 3600)
            minutes   = int ((time_diff % 3600) / 60)
            seconds   =       time_diff         % 60
            print tracks [i, 1]
            if (hours > 0) {
                printf ("%02d:%02d:%02d\n", hours, minutes, seconds)
            }
            else {
                printf (     "%02d:%02d\n",        minutes, seconds)
            }

            break
        }
        else {
            time_diff -= tracks [i, 0]
        }
    }
}
