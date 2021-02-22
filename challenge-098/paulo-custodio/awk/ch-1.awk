#!/usr/bin/gawk

# Challenge 098
#
# TASK #1 > Read N-characters
# Submitted by: Mohammad S Anwar
# You are given file $FILE.
#
# Create subroutine readN($FILE, $number) returns the first n-characters and
# moves the pointer to the (n+1)th character.
#
# Example:
# Input: Suppose the file (input.txt) contains "1234567890"
# Output:
#     print readN("input.txt", 4); # returns "1234"
#     print readN("input.txt", 4); # returns "5678"
#     print readN("input.txt", 4); # returns "90"

# read next N chars from file
function readN(filename, read_len) {
    skip_len = 0;
    if (read_files[filename])
        skip_len = read_files[filename];
    read_files[filename] = skip_len + read_len;

    dd = "dd if=" filename " status=none bs=1 skip=" skip_len " count=" read_len;
    dd | getline text;
    return text;
}

BEGIN {
    for (i = 1; i < ARGC - 1; i += 2) {
        text = readN(ARGV[i], ARGV[i+1]);
        print text;
    }
    exit 0;
}
