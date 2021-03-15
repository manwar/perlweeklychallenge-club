#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
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

BEGIN {
    yin_yang         [ 0] = "Yang"
    yin_yang         [ 1] = "Yin"
    yin_yang_size         =   2

    heavenly_stems   [ 0] = "Metal"
    heavenly_stems   [ 1] = "Metal"
    heavenly_stems   [ 2] = "Water"
    heavenly_stems   [ 3] = "Water"
    heavenly_stems   [ 4] = "Wood"
    heavenly_stems   [ 5] = "Wood"
    heavenly_stems   [ 6] = "Fire"
    heavenly_stems   [ 7] = "Fire"
    heavenly_stems   [ 8] = "Earth"
    heavenly_stems   [ 9] = "Earth"
    heavenly_stems_size   =  10

    earthly_branches [ 0] = "Monkey"
    earthly_branches [ 1] = "Rooster"
    earthly_branches [ 2] = "Dog"
    earthly_branches [ 3] = "Pig"
    earthly_branches [ 4] = "Rat"
    earthly_branches [ 5] = "Ox"
    earthly_branches [ 6] = "Tiger"
    earthly_branches [ 7] = "Rabbit"
    earthly_branches [ 8] = "Dragon"
    earthly_branches [ 9] = "Snake"
    earthly_branches [10] = "Horse"
    earthly_branches [11] = "Goat"
    earthly_branches_size =  12
}

{
    print yin_yang         [$1 % yin_yang_size],        \
          heavenly_stems   [$1 % heavenly_stems_size],  \
          earthly_branches [$1 % earthly_branches_size]
}
