#!/usr/bin/env lua

-- run <script> <variable name>

_G[arg[1]]=math.random()
print("Your variable:")
print(arg[1]..": ".._G[arg[1]])
