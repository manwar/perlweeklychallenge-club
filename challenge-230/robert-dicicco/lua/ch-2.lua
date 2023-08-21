#!/usr/bin/env lua
--[[
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-15
Challenge 230 Count Words Task 2 ( Lua )
-------------------------------------
--]]

local write = io.write
wds = {{"pay", "attention", "practice", "attend"}, {"janet", "julia", "java", "javascript"}}
prefix = {"at", "ja"}

cnt = 1

function main()
    for _, i in ipairs(wds) do
        seen = 0
        write("Input:  @words = [ ")
        for _,v in ipairs(i) do
            write(v," ")
        end
        print("]")
        print("\t$prefix = ",prefix[cnt])
        p = "^" .. prefix[cnt]
        for _,v in ipairs(i) do
            if(string.match(v,p)) then
                seen = seen + 1
            end
        end
        print("\tOutput: ",seen,"\n")
        cnt = cnt + 1
    end
end

main()
--[[
--------------------------------------
SAMPLE OUTPUT
lua .\CountWords.jl

Input:  @words = ["pay", "attention", "practice", "attend"]
        $prefix = at
        Output: 2

Input:  @words = ["janet", "julia", "java", "javascript"]
        $prefix = ja
        Output: 3
------------------------------------
--]]


