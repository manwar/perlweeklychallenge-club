#!/usr/bin/env lua

-- run <script> <number>

print((arg[1] & 15)*16 + (arg[1] >> 4 & 15))
