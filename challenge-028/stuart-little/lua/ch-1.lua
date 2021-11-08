#!/usr/bin/env lua

-- run <script> <path>

print(io.popen("file -L "..arg[1]):read("a"):match("text") and "text file" or "not a text file")
