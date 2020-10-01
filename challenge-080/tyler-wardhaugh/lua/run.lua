#!/usr/bin/env lua

local filename = arg[1]
local run_args = table.move(arg, 2, #arg, 1, {})

io.write(string.format("Running task from '%s' with {%s}:\n",
  filename, table.concat(run_args, ", ")))

require(filename).run(run_args)
