' Challenge 103
'
' TASK #2 › What’s playing?
' Submitted by: Albert Croft
' Working from home, you decided that on occasion you wanted some background
' noise while working. You threw together a network streamer to continuously
' loop through the files and launched it in a tmux (or screen) session, giving
' it a directory tree of files to play. During the day, you connected an audio
' player to the stream, listening through the workday, closing it when done.
'
' For weeks you connect to the stream daily, slowly noticing a gradual drift of
' the media. After several weeks, you take vacation. When you return, you are
' pleasantly surprised to find the streamer still running. Before connecting,
' however, if you consider the puzzle of determining which track is playing.
'
' After looking at a few modules to read info regarding the media, a quick bit
' of coding gave you a file list. The file list is in a simple CSV format, each
' line containing two fields: the first the number of milliseconds in length,
' the latter the media’s title (this example is of several episodes available
' from the MercuryTheatre.info):
'
'     1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
'     1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
'     1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
'     1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
'     1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
'     1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
'     1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"
' For this script, you can assume to be provided the following information:
'
'     * the value of $^T ($BASETIME) of the streamer script,
'     * the value of time(), and
'     * a CSV file containing the media to play consisting of the length in
' milliseconds and an identifier for the media (title, filename, or other).
' Write a program to output which file is currently playing. For purposes of
' this script, you may assume gapless playback, and format the output as you
' see fit.
'
' Optional: Also display the current position in the media as a time-like value.
'
' Example:
'
' Input: 3 command line parameters: start time, current time, file name
'
'     # Streamer start time: Tue Nov 23 12:22:03 2020
'     1606134123
'
'     # Current time:        Mon Mar  1 09:34:36 2021
'     1614591276
'
'     # filelist.csv
'
' Output:
'
'     "Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
'     00:17:33

type TrackType
    secs as integer
    title as string
end type

redim shared tracks(1) as TrackType

sub read_tracks(filename as string)
    dim fn as integer, text as string, i as integer, p1 as integer, p2 as integer

    fn=FreeFile
    open filename for input as #fn
    do while not eof(fn)
        line input #fn, text
        if i>ubound(tracks) then redim preserve tracks(i)
        tracks(i).secs=val(text)/1000
        p1=instr(text,""""): p2=instr(p1+1,text,"""")
        tracks(i).title=mid(text,p1+1,p2-p1-1)
        i=i+1
    loop
end sub

function tracks_secs() as integer
    dim i as integer, secs as integer

    for i=0 to ubound(tracks)
        secs=secs+tracks(i).secs
    next
    tracks_secs=secs
end function

sub show_track(secs as integer)
    dim i as integer, hh as integer, mm as integer, ss as integer

    secs=secs mod tracks_secs()
    for i=0 to ubound(tracks)
        if secs<tracks(i).secs then     ' playing this title
            hh=int(secs/3600): secs=secs mod 3600
            mm=int(secs/60): secs=secs mod 60
            ss=secs

            print tracks(i).title
            print right("00"+trim(str(hh)),2);":";
            print right("00"+trim(str(mm)),2);":";
            print right("00"+trim(str(ss)),2)
            exit sub
        else
            secs=secs-tracks(i).secs
        end if
    next
end sub

' main
dim start_secs as integer, current_secs as integer, filename as string
start_secs=val(command(1))
current_secs=val(command(2))
filename=command(3)

read_tracks filename
show_track current_secs-start_secs
