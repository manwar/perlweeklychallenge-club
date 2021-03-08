#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

#
# We're reading years from standard input, one year per line, outputting
# years from the sexagenary cycle [1]. This is slightly more than what
# the challenge ask; the challenge asks to output the heavenly stem [2],
# and the earthly branch [3]. But we also output its Yin/Yang.
#
# [1] https://en.wikipedia.org/wiki/Sexagenary_cycle
# [2] https://en.wikipedia.org/wiki/Heavenly_Stems
# [3] https://en.wikipedia.org/wiki/Earthly_Branches
#

#
# Each of the cycles have been rotated so the first entry corresponds to
# the year 0 in the Proleptic Gregorian calendar. (We're using the
# convention of having a year 0, as per ISO 8601).
# That way, we can just mod the year with the number of entries, without
# first having to subtract something from the year.
#
# The heavenly stems last for 2 years, so we just duplicate the entries.
#

declare -a yin_yang
declare -a heavenly_stems
declare -a earthly_branches

yin_yang=(Yang Yin)
yin_yang_size=2
heavenly_stems=(Metal Metal Water Water Wood Wood Fire Fire Earth Earth)
heavenly_stems_size=10
earthly_branches=(Monkey Rooster Dog    Pig   Rat   Ox
                  Tiger  Rabbit  Dragon Snake Horse Goat)
earthly_branches_size=12



while read year
do    echo ${yin_yang[$((year % yin_yang_size))]}                 \
           ${heavenly_stems[$((year % heavenly_stems_size))]}     \
           ${earthly_branches[$((year % earthly_branches_size))]}
done
