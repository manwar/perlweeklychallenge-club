#! /usr/bin/python3

char="^"
shape=[3,-3,-4,-5,-5,-5,-5,-5,-4,-3,3,1,1,1,3,1,1]
mx=max(abs(i) for i in shape)

for row in shape:
    if row>0:
        line=char * row
    else:
        line=(" "* -row) + char
    ll=len(line)
    if ll <= mx:
        line += " " * (mx-ll+1)
    f=line[1:]
    f=f[::-1]
    print(f+line)
