#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Union


def shortest_route(routes: List[List[int]], source: int,
                   destination: int) -> Union[int, List[int]]:
    graph = {}

    for route in routes:
        for i in range(len(route) - 1):
            if route[i] not in graph:
                graph[route[i]] = []
            if route[i + 1] not in graph:
                graph[route[i + 1]] = []
            graph[route[i]].append(route[i + 1])
            graph[route[i + 1]].append(route[i])

    queue = [[source]]
    visited = {source: True}

    while queue:
        path = queue.pop(0)
        node = path[-1]

        if node == destination:
            return path

        for neighbor in graph[node]:
            if neighbor not in visited:
                visited[neighbor] = True
                queue.append(path + [neighbor])

    return -1


if __name__ == "__main__":
    routes = [[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]]
    source = 1
    destination = 7

    result = shortest_route(routes, source, destination)
    print("Output: ", end="")
    if isinstance(result, list):
        print("(", ", ".join(map(str, result)), ")", sep="")
    else:
        print("-1")
