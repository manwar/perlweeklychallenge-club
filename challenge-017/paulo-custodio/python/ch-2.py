#!/usr/bin/python3

# Challenge 017
#
# Task #2
# Create a script to parse URL and print the components of URL. According to
# Wiki page, the URL syntax is as below:
#
# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
#
# For example: jdbc://user:password@localhost:3306/pwc?profile=true#h1
#
#   scheme:   jdbc
#   userinfo: user:password
#   host:     localhost
#   port:     3306
#   path:     /pwc
#   query:    profile=true
#   fragment: h1

import sys
import re

url = sys.stdin.read().rstrip()

word = r"(?i:[a-z_][a-z_0-9+.-]*)"
pathre = r"(?:"+word+r"|/)+"

# scheme(1)
matches = re.match(r"^("+word+r"):", url)
if matches:
    scheme = matches.group(1)
    url = url[matches.end(0):]
else:
    scheme = ""

# userinfo(1), host(2), port(3)
matches = re.match(r"^//"+ \
                   r"(?:("+word+r"(?:[:].*?)?)[@])?"+ \
                   r"("+word+r")"+ \
                   r"(?:[:](\d+))?", url)
if matches:
    if matches.group(1):
        userinfo = matches.group(1)
    else:
        userinfo = ""

    host = matches.group(2)

    if matches.group(3):
        port = matches.group(3)
    else:
        port = ""

    url = url[matches.end(0):]
else:
    userinfo, host, port = "", "", ""

# path(1), query(2), fragment(3)
matches = re.match(r"("+pathre+r")"+ \
                   r"(?:[?]([^#]*))?"+ \
                   r"(?:[#](.*))?"+ \
                   r"$", url)
if matches:
    path = matches.group(1)

    if matches.group(2):
        query = matches.group(2)
    else:
        query = ""

    if matches.group(3):
        fragment = matches.group(3)
    else:
        fragment = ""

    url = url[matches.end(0):]
else:
    path, query, fragment = "", "", ""

print("scheme:   "+scheme)
print("userinfo: "+userinfo)
print("host:     "+host)
print("port:     "+port)
print("path:     "+path)
print("query:    "+query)
print("fragment: "+fragment)
