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
        do while left(text,1)=delim: text=mid(text,2): loop ' eat front delimiters
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

function common_email(byref aa as integer, byref bb as integer) as boolean
    dim emails_a() as string, emails_b() as string
    dim a as integer, i as integer, b as integer, j as integer
    for a=0 to ubound(names)
        split(emails(a),,emails_a())
        for i=0 to ubound(emails_a)
            for b=0 to ubound(names)
                if a<>b then
                    split(emails(b),,emails_b())
                    for j=0 to ubound(emails_b)
                        if emails_a(i)=emails_b(j) then
                            aa=a: bb=b: common_email=true
                            exit function
                        end if
                    next
                end if
            next
        next
    next
    common_email=false
end function

sub sort(s() as string)
    dim i as integer, j as integer, tmp as string
    for i=0 to ubound(s)-1
        for j=i+1 to ubound(s)
            if s(i)>s(j) then tmp=s(i): s(i)=s(j): s(j)=tmp
        next
    next
end sub

function sort_uniq_emails(emails as string) as string
    dim s() as string, i as integer, last as string, ret as string
    split emails,,s()
    sort s()
    ret=""
    for i=0 to ubound(s)
        if s(i)<>last then
            ret=ret+s(i)+" "
            last=s(i)
        end if
    next
    sort_uniq_emails=ret
end function

sub merge_account(a as integer, b as integer)
    dim all_emails as string, i as integer
    all_emails=sort_uniq_emails(emails(a)+" "+emails(b))
    emails(a)=all_emails
    for i=b to ubound(names)-1
        names(i)=names(i+1)
        emails(i)=emails(i+1)
    next
    redim preserve names(ubound(names)-1)
    redim preserve emails(ubound(emails)-1)
end sub

sub merge_accounts()
    dim a as integer, b as integer
    do while common_email(a, b)
        merge_account(a, b)
    loop
end sub

dim i as integer
collect_args
merge_accounts
for i=0 to ubound(names)
    print names(i);" ";emails(i)
next
