#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#


#
# If we haven't ready in the content of "filename" yet, do so,
# and store it into an array, indexed by the filename.
#
# Remove the first amount characters of the stored content, and
# return it.
#
function readN(filename, amount) {
    if (!content [filename]) {
        old_rs = RS
        #
        # We want to read the entire file, so we pick a
        # character which should not be present in the file
        # as the record separator.
        #
        RS = "\000"
        getline content [filename] < filename
        #
        # Restore the record separator.
        #
        RS = old_rs
    }
    r = substr (content [filename], 1, amount)
    content [filename] = substr (content [filename], amount + 1)
    return r
}

{
    print readN($1, $2)
}
