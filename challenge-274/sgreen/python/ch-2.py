#!/usr/bin/env python3

from dataclasses import dataclass
import sys


@dataclass
class Route:
    freq: int
    offset: int
    length: int


def calculate_departures(routes):
    """
    Calculate the departures for each minute based on the given routes.

    Args:
        routes (list): A list of Route objects representing bus routes.

    Returns:
        dict: A dictionary where the keys are minutes and the values are the
        length of the shortest route departing at that minute.
    """
    departures = {}
    for route in routes:
        start_minute = route.offset % route.freq
        while start_minute < 60:
            if start_minute in departures and departures[start_minute] < route.length:
                # This is a slower bus, so we can ignore it
                continue
            departures[start_minute] = route.length
            start_minute += route.freq

    return departures


def next_bus(departures, minute):
    """
    Find the next bus departure time after the given minute.

    Args:
        departures (dict): A dictionary containing the departure times as keys and the duration of each departure as values.
        minute (int): The minute after which to find the next bus departure time.

    Returns:
        tuple: A tuple containing the start minute and the end minute of the next bus departure.
    """
    start_minute = minute
    while True:
        if start_minute in departures:
            return start_minute, start_minute + departures[start_minute]

        start_minute += 1
        if start_minute == 60:
            start_minute = 0


def bus_route(routes: list[Route]) -> list[int]:
    # Get the start time of all bus routes
    departures = calculate_departures(routes)
    skip_bus = []

    for minute in range(60):
        start_minute, end_minute = next_bus(departures, minute)

        # Check if there are any faster buses
        for second_bus_start in range(start_minute + 1, end_minute):
            if second_bus_start % 60 not in departures:
                # No bus departs at this minute
                continue
            if second_bus_start + departures[second_bus_start % 60] < end_minute:
                # The second bus is faster
                break
        else:
            # No second bus will get there sooner
            continue

        skip_bus.append(minute)

    return skip_bus


def main():
    # Convert input into triplets of integers
    routes = []
    for i in range(1, len(sys.argv), 3):
        routes.append(Route(int(sys.argv[i]), int(
            sys.argv[i+1]), int(sys.argv[i+2])))
    result = bus_route(routes)
    print(result)


if __name__ == '__main__':
    main()
