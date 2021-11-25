#!/usr/bin/python3

# Challenge 021
#
# Task #2
# Write a script for URL normalization based on rfc3986. This task was shared by
# Anonymous Contributor.
#
# According to Wikipedia, URL normalization is the process by which URLs are
# modified and standardized in a consistent manner. The goal of the
# normalization process is to transform a URL into a normalized URL so it is
# possible to determine if two syntactically different URLs may be equivalent.

import sys
import re

def decode_triplets(hex):
    c = chr(int(hex, 16))
    if re.match(r"[a-zA-Z0-9\-._~]", c):
        return c
    else:
        return '%'+hex.upper()

def upper_repl(matchobj):
    return matchobj.group(0).upper()

def sheme_host_repl(matchobj):
    return matchobj.group(1).lower()+matchobj.group(2)+matchobj.group(4).lower()

def decode_triplets_repl(matchobj):
    return decode_triplets(matchobj.group(1))

def norm_uri(uri):
    # Converting percent-encoded triplets to uppercase
    uri = re.sub(r"%[0-9a-f]{2}", upper_repl, uri, flags=re.IGNORECASE)

    # Converting the scheme and host to lowercase
    uri = re.sub(r"^(\w+://)((.*?@)?)(.*?/)", sheme_host_repl, uri)

    # Decoding percent-encoded triplets of unreserved characters
    uri = re.sub(r"%([0-9a-f]{2})", decode_triplets_repl, uri, flags=re.IGNORECASE)

    # Removing dot-segments
    while True:
        uri, count = re.subn(r"/\./", "/", uri, count=1)
        if count==0:
            break
    while True:
        uri, count = re.subn(r"/[^/]+/\.\./", "/", uri, count=1)
        if count==0:
            break

    # Converting an empty path to a "/" path
    uri = re.sub(r"^(\w+://[^/]+)$", r"\1/", uri)

    # Removing the default port
    uri = re.sub(r"^(http://[^/]+?):80/", r"\1/", uri)

    return uri

print(norm_uri(sys.argv[1]))
