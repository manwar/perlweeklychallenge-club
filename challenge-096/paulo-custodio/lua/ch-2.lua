#!/usr/bin/env lua

--[[
Challenge 096

# TASK #2 > Edit Distance
# Submitted by: Mohammad S Anwar
# You are given two strings $S1 and $S2.
#
# Write a script to find out the minimum operations required to convert $S1
# into $S2. The operations can be insert, remove or replace a character. Please
# check out Wikipedia page for more information.
#
# Example 1:
# Input: $S1 = "kitten"; $S2 = "sitting"
# Output: 3
#
# Operation 1: replace 'k' with 's'
# Operation 2: replace 'e' with 'i'
# Operation 3: insert 'g' at the end
# Example 2:
# Input: $S1 = "sunday"; $S2 = "monday"
# Output: 2
#
# Operation 1: replace 's' with 'm'
# Operation 2: replace 'u' with 'o'

# NOTE: the  Wagner-Fischer Distance algorithm builds a table of distances
#       from which the operations can be deduced
--]]

function wag_fis_dist(a, b)
    -- define a table where d[i,j] is the Levenshtein distance between
    -- first i chars of a and first j chars of b
	local d = {}

    -- source prefixes can be transformed into empty string by dropping chars
	for i=0,#a do
		d[i] = {}
		d[i][0] = i
	end

    -- target prefixes can be reached from empty source prefix by inserting chars
	for j=0,#b do
		d[0][j] = j
	end

    -- flood-fill the rest of the table
    for j=1,#b do
        for i=1,#a do
			local subst_cost = 0
			if string.sub(a,i,i) ~= string.sub(b,j,j) then subst_cost = 1; end
            d[i][j] = math.min(d[i-1][j]+1,              -- deletion
							   d[i][j-1]+1,              -- insertion
							   d[i-1][j-1]+subst_cost)   -- substitution
		end
	end

    -- distance is in lower bottom cell
    io.write(d[#a][#b], "\n")
	
    -- traverse the minimum path
    local i, j, step = 0, 0, 0
    while i < #a or j < #b do
        local dir, delta, min_dir, min_delta = 0,0,0,#a+#b

        -- search shortest path in priority SE, E, S
        if i < #a and j < #b then
			dir, delta = 'SE', d[i+1][j+1] - d[i][j]
            if delta < min_delta then min_dir, min_delta = dir, delta; end
        end
        if j < #b then
			dir, delta = 'E', d[i][j+1] - d[i][j]
            if delta < min_delta then min_dir, min_delta = dir, delta; end
        end
        if i < #a then
			dir, delta = 'S', d[i+1][j] - d[i][j]
            if delta < min_delta then min_dir, min_delta = dir, delta; end
        end

        -- apply shortest path and show steps
		if min_dir == 'SE' then
			i, j = i+1, j+1
            if string.sub(a,i,i) ~= string.sub(b,j,j) then
                step = step+1
                io.write("Operation ", step, ": replace '",
                         string.sub(a,i,i), "' with '",
						 string.sub(b,j,j), "'\n")
            end
		elseif min_dir == 'E' then
			j = j+1
            step = step+1
            if j == #b then
                io.write("Operation ", step, ": insert '",
                         string.sub(b,j,j), "' at end\n")
            else
                io.write("Operation ", step, ": insert '", 
                         string.sub(b,j,j), "' at position ", j, "\n")
            end
        elseif min_dir == 'S' then
            i = i+1
            step = step+1
            if i == #a then
                io.write("Operation ", step, ": insert '",
						 string.sub(a,i,i), "' at end\n")
            else
                io.write("Operation ", step, ": insert '",
                         string.sub(a,i,i), "' at position ", i, "\n")
            end
        else
            assert(false, "invalid direction")
        end
    end
end

wag_fis_dist(arg[1], arg[2])
