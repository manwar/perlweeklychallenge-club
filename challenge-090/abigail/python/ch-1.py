import fileinput
import string

for line in fileinput . input ():
    line = line . rstrip ()
    print len (line)
    print line . translate (string . maketrans ("ATCG", "TAGC"))
