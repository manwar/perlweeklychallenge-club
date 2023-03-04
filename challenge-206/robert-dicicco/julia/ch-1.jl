#!/use/bin/env julia
#=
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02=28
Challenge Shorteest Times ( Julia )
---------------------------------------
Remember, in Julia, array offsets start at 1
=#
using Printf
using Combinatorics

times = [["00:00", "23:55", "20:00"],["01:01", "00:50", "00:57"],["10:10", "09:30", "09:00", "09:55"]]
minutes = Any[] # array to store times converted to minutes

function ResetValues()
    shortest = 1441         # This should be more than the number of minutes in 24 hrs
    empty!(minutes)         # this clears out our holding array
end

for tm in times
    @printf("Input: @array = %s\n",tm)
    ln = length(tm)         # get the number of entries in our time array
    for x in 1:ln           # and for each entry, convert to minutes and store in our 'minutes' array
        times_split = split(tm[x],':')
        hrs = parse(Int64, times_split[1])
        mins = parse(Int64, times_split[2])
        if hrs == 0 && mins == 0
            hrs = 24
        end
        hrs = hrs * 60
        time_in_mins = hrs+mins
        push!(minutes,time_in_mins)
    end
    shortest = 1441
    for combos in combinations(minutes,2)       # create a list of 2 times to compare to each other
        minval = abs(combos[1] - combos[2])
        if minval < shortest                    # and find the shortest
           shortest = minval
        end
    end
    @printf("Output: %d\n\n",shortest)          # print it, and reset values for next group
    ResetValues()
end

#=
---------------------------------------
SAMPLE OUTPUT
julia .\ShortestTime.jl
Input: @array = ["00:00", "23:55", "20:00"]
Output: 5

Input: @array = ["01:01", "00:50", "00:57"]
Output: 4

Input: @array = ["10:10", "09:30", "09:00", "09:55"]
Output: 15
---------------------------------------
=#

