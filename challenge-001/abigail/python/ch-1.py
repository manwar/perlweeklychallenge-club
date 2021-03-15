#
# See ../READE,md
#

#
# Run as python ch-1.py < input-file
#
import fileinput

for line in fileinput . input ():
    print line . replace ("e", "E"), line . count ("e")
