' Challenge 209
'
' Task 2: Merge Account
' Submitted by: Mohammad S Anwar
'
' You are given an array of accounts i.e. name with list of email addresses.
'
' Write a script to merge the accounts where possible. The accounts can only
' be merged if they have at least one email address in common.
'
' Example 1:
'
' Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
'                      ["B", "b1@b.com"],
'                      ["A", "a3@a.com", "a1@a.com"] ]
'                    ]
'
' Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
'           ["B", "b1@b.com"] ]
'
' Example 2:
'
' Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
'                      ["B", "b1@b.com"],
'                      ["A", "a3@a.com"],
'                      ["B", "b2@b.com", "b1@b.com"] ]
'
' Output: [ ["A", "a1@a.com", "a2@a.com"],
'           ["A", "a3@a.com"],
'           ["B", "b1@b.com", "b2@b.com"] ]

dim shared names() as string
dim shared emails() as string

sub collect_args()
	dim i as integer, j as integer, row as integer
	row=1
	i=1
	do while command(i)<>""
		redim preserve names(row) as string
		redim preserve emails(row) as string
		names(row)=command(i)
		i=i+1
		do while command(i)<>"" and command(i)<>","
			emails(row)=emails(row)+command(i)+" "
			i=i+1
		loop
		if command(i)="," then i=i+1: row=row+1
	loop
end sub

sub split(byval text as string, delim as string = " ", ret() as string)
	dim p as integer, count as integer
	count=0
	do
		do while left(text,1)=delim: text=mid(text,2): loop	' eat front delimiters
		if text="" then exit do
		redim preserve ret(count) as string
		p=instr(text,delim)
		if p<1 then
			ret(count)=text
			exit do
		else
			ret(count)=left(text,p-1)
			text=mid(text,p+1)
			count=count+1
		end if
	loop
end sub

function common_email(byref a as integer, byref b as integer) as boolean
	dim emails_a() as string, emails_b() as string
	dim i as integer, j as integer, k as integer
	for i=0 to ubound(names)
		split(emails(i),,emails_a())
		print names(i);" ";
		for j=0 to ubound(emails_a): print emails_a(j);" ";: next
		print
	next
	common_email=false
end function


dim i as integer, a as integer, b as integer

collect_args
if common_email(a, b) then print a, b
for i=0 to ubound(names)
	print i;names(i) ',emails(i)
next
