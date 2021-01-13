#!/usr/bin/env python

from collections import namedtuple
import heapq

Node = namedtuple('Node', 'pos, path, cost, visited')

def manhattan_dist(pos, goal):
    return goal[0] - pos[0] + goal[1] - pos[1]

def next_states(pos, matrix):
    xmax, ymax = len(matrix), len(matrix[0])
    x, y = pos
    return [(x1, y1) 
            for x1, y1 in [(x-1, y), (x+1, y), (x, y+1), (x, y-1)]
            if (0 <= x1 < xmax) and (0 <= y1 < ymax)]

def move(curr_node, pos, matrix):
    cost = matrix[pos[0]][pos[1]]
    return Node(pos, curr_node.path + [cost], curr_node.cost + cost, curr_node.visited.union([pos]))


def solve(matrix):
    init = (0, 0)
    goal = (len(matrix)-1, len(matrix[0])-1)

    curr_cost = matrix[init[0]][init[1]]
    states = [(manhattan_dist(init, goal), Node(init, [curr_cost], curr_cost, set([init])))]
    heapq.heapify(states)

    while states:
        _, best_node = heapq.heappop(states)
        if best_node.pos == goal:
            print_result(best_node)
            break
        for state in next_states(best_node.pos, matrix):
            next_node = move(best_node, state, matrix)
            if not state in best_node.visited:
                heapq.heappush(states, (next_node.cost + manhattan_dist(next_node.pos, goal),
                                        next_node))

def print_result(node):
    print(f"Best path: {node.cost} ({'->'.join(str(p) for p in node.path)})")


solve([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])

#More complicated case
solve([[1, 2, 3],
       [12, 2, 6],
       [-3, 6, 20],
       [2, 8, 9]])

