#!/usr/bin/env python
# -*- coding: utf-8 -*-


def find_open_rooms() -> [int]:
    rooms_count = 500
    rooms = [False] * (rooms_count + 1)

    for i in range(1, rooms_count + 1):
        for j in range(i, rooms_count + 1, i):
            rooms[j] = not rooms[j]

    open_rooms = [i for i in range(1, rooms_count + 1) if rooms[i]]
    return open_rooms


if __name__ == "__main__":
    open_rooms = find_open_rooms()
    print("Open rooms:", ", ".join(map(str, open_rooms)))
