#! /usr/bin/python3
 
def em(aa,bb):
    a=aa
    b=bb
    s=0
    demo=list()
    while (a > 0):
        line=' '.join([format(a,'5d'),format(b,'5d')])
        if (a & 1 == 1):
            s += b
            line=' '.join([line,'->',format(b,'5d')])
        a = a >> 1
        b = b << 1
        demo.append(line)
    demo.append('               -----')
    demo.append('               ' + format(s,'5d'))
    for i in demo:
        print(i)
    return s

em(13,238)
