#!/usr/bin/env lua

-- run <script> <string>

print(arg[1]:upper():gsub(".",{A='T',T='A',C='G',G='C'}))
