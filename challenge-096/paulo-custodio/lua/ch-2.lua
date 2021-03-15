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
    return d[#a][#b]
end

io.write(wag_fis_dist(arg[1], arg[2]), "\n")
