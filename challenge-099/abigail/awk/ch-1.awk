#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    string  = $1
    pattern = $2
    split (pattern, characters, "")
    regexp  = ""
    for (i = 1; i <= length (characters); i ++) {
        if (characters [i] == "?") {
            regexp = regexp "."
            continue;
        }
        if (characters [i] == "*") {
            regexp = regexp ".*"
            continue;
        }
        if (match (characters [i], "[^a-zA-Z0-9]")) {
            regexp = regexp "\\"
        }
        regexp = regexp characters [i]
    }
    print match (string, "^" regexp "$") ? 1 : 0
}

