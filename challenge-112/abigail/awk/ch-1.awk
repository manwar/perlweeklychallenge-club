#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    FS = "/"   # So we split into directory parts
}

{
    delete path
    j = 0                            # Tracks the number of parts in
                                     # the canonical part.
    for (i = 1; i <= NF; i ++) {     # Loop over directory parts
        if ($i == "") {              # Skip empty parts
            continue;
        }
        if ($i == ".") {             # Skip current directory
            continue;
        }
        if ($i == "..") {            # Back up to parent directory
            if (j > 0) {
                j --
            }
            continue;
        }
        path [j] = $i                # Copy
        j ++
    }
    if (j == 0) {                    # Root directory
        print "/"
    }
    else {                           # Print parts, preceeded by a /
        for (k = 0; k < j; k ++) {
            printf "/%s", path [k]
        }
        print ""
    }
}
