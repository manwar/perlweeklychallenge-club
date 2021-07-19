#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

def shortest_path (matrix, start, to, exclude):
    if 1 + len (exclude . keys ()) == len (matrix):
        return matrix [start] [to], [to]

    shortest    = 9999999999999999999
    sh_path     = []
    new_exclude = exclude . copy ()
    new_exclude [start] = 1

    for next in range (len (matrix)):
        if next == start or next == to or next in exclude:
            continue
        length, path = shortest_path (matrix, next, to, new_exclude)
        if  shortest > length + matrix [start] [next]:
            shortest = length + matrix [start] [next]
            sh_path  = [next] + path

    return shortest, sh_path


matrix = []
for line in fileinput . input ():
    matrix . append (list (map (lambda x: int (x), line . split (" "))))

length, path = shortest_path (matrix, 0, 0, {})

print (length)
print (0, " " . join (map (lambda x: str (x), path)))
