#!/opt/local/bin/gawk

#
# See ../README.md
#

#
# Run as: gawk -f ch-1.gawk < input-file
# This must be run as GNU AWK.
#


{
    match ($0, /^([0-9]?[0-9]):([0-9][0-9])([AaPp]?)m?/, parts);
    printf "%02d:%02d%s\n",                                              \
             parts [3] ? (parts [1] % 12) + (parts [3] == "a" ? 0 : 12)  \
                       : (parts [1] % 12) ? (parts [1] % 12) : 12,       \
             parts [2],                                                  \
             parts [3] ? ""                                              \
                       : parts [1] >= 12 ? "pm" : "am"
}
