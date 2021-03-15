#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

--
-- We're reading a start time, the current time, and a file name
-- from STDIN, separated by white space. The file contains the
-- tracks played.
--

for line in io . lines () do
    local _, _, start_time, current_time, file_name =
                line : find ("(%d+)%s+(%d+)%s+(%S+)")

    --
    -- Time difference in milliseconds
    --
    local time_diff  = (current_time - start_time) * 1000

    local tracks     = {}
    local total_time = 0

    --
    -- Read in the media file; store the results in the
    -- table tracks.
    --
    for track in io . lines (file_name) do
        local _, _, play_time, title = track : find ("(%d+),(.*)")
        local record = {}
        record [0] = play_time
        record [1] = title
        total_time = total_time + play_time
        table . insert (tracks, record)
    end

    --
    -- We're not interested in playing full loops.
    --
    time_diff = time_diff % total_time

    --
    -- Find the current track playing. If time_diff is less than the
    -- play time of the track, this is the track currently playing. If
    -- so, print the track name (with quotes, as given in the example --
    -- although they don't belong there, as they're from the CSV encoding;
    -- for that reason, we won't deescape anything else either). Otherwise
    -- (track length is shorter than time_diff), we subtrack the length
    -- of the track from time_diff, and continue checking the next track.
    --
    for _, track in ipairs (tracks) do
        if   time_diff - track [0] < 0
        then time_diff     =  math . floor  (time_diff / 1000)
             local hours   =  math . floor  (time_diff / 3600)
             local minutes =  math . floor ((time_diff % 3600) / 60)
             local seconds =                 time_diff         % 60
        
             --
             -- Format a time string
             --
             local time
             if   hours > 0
             then time = string .
                         format ("%02d:%02d:%02d", hours, minutes, seconds)
             else time = string .
                         format (     "%02d:%02d",        minutes, seconds)
             end
             print (track [1])
             print (time)
             break
        else time_diff = time_diff - track [0]
        end
    end
end


