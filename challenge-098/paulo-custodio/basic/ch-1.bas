' Challenge 098
'
' TASK #1 › Read N-characters
' Submitted by: Mohammad S Anwar
' You are given file $FILE.
'
' Create subroutine readN($FILE, $number) returns the first n-characters and
' moves the pointer to the (n+1)th character.
'
' Example:
' Input: Suppose the file (input.txt) contains "1234567890"
' Output:
'     print readN("input.txt", 4); # returns "1234"
'     print readN("input.txt", 4); # returns "5678"
'     print readN("input.txt", 4); # returns "90"

' store list of seen files
type tFile
    sName as string
    nFile as integer
end type

dim shared aFiles() as tFile

' return filenum of open file or open it if first time
function next_file(sName as string) as integer
    dim i as integer

    for i=lbound(aFiles) to uBound(aFiles)
        if aFiles(i).sName=sName then
            next_file=aFiles(i).nFile
            exit function
        end if
    next

    i=ubound(aFiles)+1
    redim preserve aFiles(i)
    aFiles(i).sName=sName
    aFiles(i).nFile=FreeFile
    if open(sName for binary access read as #aFiles(i).nFile) <> 0 then
        print "File not found:"; sName
        end
    end if

    next_file=aFiles(i).nFile
end function

' read next N chars from file
function readN(sName as string, nNum as integer) as string
    dim nFile as integer, sText as string

    nFile=next_file(sName)
    sText=string(nNum,0)    ' allocate nNum zeros
    get #nFile, , sText     ' read
    sText=rtrim(sText)      ' remove zeros if file ended short

    readN=sText
end function

' main
dim i as integer
i=1
do while command(i+1)<>""
    print readN(command(i), val(command(i+1)))
    i=i+2
loop
