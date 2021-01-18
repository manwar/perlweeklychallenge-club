import fileinput

for line in fileinput . input ():
    words = line . strip () . split ()
    words . reverse ()
    print (" " . join (words))
