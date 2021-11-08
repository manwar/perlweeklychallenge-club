#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    |line|
    #
    # Read the data; turn the strings into a graph, where the first
    # and last character of each string are the nodes, and we have
    # a directed edge from the beginning to the end of a string.
    #
    nodes = {}
    graph = {}
    line . split . each do
        |string|
        first = string [0, 1]
        last  = string [-1, 1]
        nodes [first]   = 1
        nodes [last]    = 1
        graph [first] ||= {}
        graph [last]  ||= {}
        graph [first] [last] = 1
    end

    #
    # Calculate the transitive closure of the graph using the
    # Floyd Warshall algorithm.
    #
    nodes . each do 
        |k, _|
        nodes . each do
            |i, _|
            nodes . each do
                |j, _|
                if   graph [i] [k] and graph [k] [j]
                then graph [i] [j] = 1
                end
            end
        end
    end

    #
    # We have a loop iff there is node which is reachable from itself.
    #
    out = 0
    nodes . each do
        |i, _|
        if   graph [i] [i]
        then out = 1
        end
    end
    
    puts (out)
end
