#!/usr/bin/env python3


def bus_routes(timetables):
    ''' Several bus routes start from a bus stop near my home, and go to the
    same stop in town. They each run to a set timetable, but they take
    different times to get into town.

    Find the times - if any - I should let one bus leave and catch a strictly
    later one in order to get into town strictly sooner.

    An input timetable consists of the service interval, the offset within the
    hour, and the duration of the trip.
    >>> bus_routes([ [12, 11, 41], [15, 5, 35] ])
    [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
    >>> bus_routes([ [12, 3, 41], [15, 9, 35], [30, 5, 25] ])
    [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59]
    '''
    routes = [Route(i, o, d) for i, o ,d in timetables]
    times = []
    for current in range(0, 60):
        next_bus = [(r.next_bus(current), r.end_trip(current)) for r in routes]
        sorted_next_bus = sorted(next_bus)
        if any(sorted_next_bus[0][1] > end for end in list(zip(*sorted_next_bus[1:]))[1]):
            times.append(current)
    return times


class Route:
    def __init__(self, interval, offset, duration):
        self.interval = interval
        self.offset = offset
        self.duration = duration

    def __repr__(self):
        class_name = type(self).__name__
        return f"{class_name}: {self.interval} {self.offset} {self.duration}"

    def next_bus(self, current):
        time = self.offset
        while current > time:
            if time + self.interval > 59:
                time = 60 + self.offset
            else:
                time += self.interval
        return time

    def end_trip(self, current):
        return self.next_bus(current) + self.duration


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
