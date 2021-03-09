' Challenge 092
'
' TASK #2 › Insert Interval
' Submitted by: Mohammad S Anwar
' You are given a set of sorted non-overlapping intervals and a new interval.
'
' Write a script to merge the new interval to the given set of intervals.
'
' Example 1:
' Input $S = (1,4), (8,10); $N = (2,6)
' Output: (1,6), (8,10)
' Example 2:
' Input $S = (1,2), (3,7), (8,10); $N = (5,8)
' Output: (1,2), (3,10)
' Example 3:
' Input $S = (1,5), (7,9); $N = (10,11)
' Output: (1,5), (7,9), (10,11)

redim shared timeline(1) as Boolean

sub fill_timeline()
	dim i as integer, j as integer, p as integer, bg as integer, ed as integer
	i=1
	do while command(i)<>""
		' parse begin,end
		p=instr(command(i),",")
		if p=0 then error 5
		bg=val(command(i))
		ed=val(mid(command(i),p+1))
		' resize timeline if needed
		if 2*ed>ubound(timeline) then
			redim preserve timeline(2*ed+2)
		end if
		
		' fill interval
		for j=2*bg to 2*ed
			timeline(j)=true
		next
		i=i+1
	loop
end sub

sub print_timeline()
	dim i as integer
	redim intervals(0) as integer
	
	for i=lbound(timeline) to ubound(timeline)-1
		if timeline(i)=false and timeline(i+1)=true then
			redim preserve intervals(ubound(intervals)+1)
			intervals(ubound(intervals))=int(i/2)+1
		elseif timeline(i)=true and timeline(i+1)=false then
			redim preserve intervals(ubound(intervals)+1)
			intervals(ubound(intervals))=int(i/2)
		end if
	next
	
	for i=1 to ubound(intervals) step 2
		print "(";trim(str(intervals(i)));",";trim(str(intervals(i+1)));")";
		if i+2<ubound(intervals) then print ", ";
	next
	print
end sub

' main
fill_timeline
print_timeline
