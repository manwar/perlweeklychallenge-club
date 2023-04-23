#!/usr/bin/env python3

import json
import sys


def find_pairs(nodes, path):
    '''Find a node with the target that we haven't seen before'''
    target = nodes[path[-1][0]][path[-1][1]]
    pairs = []

    for x in range(len(nodes)):
        # we don't want to search the current node
        if x == nodes[-1][0]:
            continue

        for y in range(len(nodes[x])):
            if nodes[x][y] == target and [x, y] not in path:
                pairs.append([x, y])

    # Return new pairs (if any)
    return pairs


def find_routes(nodes, path, end):
    '''Walk through the node and maybe switch node number'''

    # The last value is the current node number we are on
    current_node = nodes[path[-1][0]]
    current_pos = path[-1][1]
    shortest_solution = None

    # Move forward and backwards to see if we can find another node to link to
    #  or the target
    for direction in (-1, 1):
        # The end is 0 when moving backwards, or the number of numbers in this
        #  node when moving forward
        end_pos = -1 if direction == -1 else len(current_node)
        new_nodes = []

        for y in range(current_pos+direction, end_pos, direction):
            new_nodes += [[path[-1][0], y]]
            if current_node[y] == end:
                # We have hit our target, return the solution
                return path + new_nodes

            # Find out other nodes with this number, that we haven't seen before
            pairs = find_pairs(nodes, path + new_nodes)
            for pair in pairs:
                # Call the function again with the new list of node/number
                # We use -1 to exclude the current position to avoid dups
                solution = find_routes(nodes, path+new_nodes[:-1]+[pair], end)
                if shortest_solution is None or len(shortest_solution) > len(solution):
                    shortest_solution = solution

    return shortest_solution


def main(nodes, start, end):
    '''Find the shortest route between start and end'''
    shortest_solution = None

    for x in range(len(nodes)):
        for y in range(len(nodes[x])):
            if nodes[x][y] == start:
                # This is a starting point
                solution = find_routes(nodes, [[x, y]], end)

                if shortest_solution is None or len(shortest_solution) > len(solution):
                    # This the shortest solution we have found so far
                    shortest_solution = solution

    if not shortest_solution:
        print('-1')
        return

    # We now have the shortest solution. Turn the x,y pairs into numbers
    routes = [nodes[x[0]][x[1]] for x in shortest_solution]
    print(*routes, sep=',')


if __name__ == '__main__':
    main(json.loads(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]))
