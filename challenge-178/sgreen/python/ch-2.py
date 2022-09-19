#!/usr/bin/env python

import sys
from datetime import datetime, timedelta


def main(dt, hours):
    # It's easier to work in minutes
    minutes = hours * 60

    # Parse the date time input
    start = datetime.strptime(dt, r'%Y-%m-%d %H:%M')

    # Can't start on a weekend
    if start.weekday() >= 5:
        raise ValueError("You can't start in the weekend")

    # Can't start outside office hours
    if start.hour < 9 or start.hour > 18 or (start.hour == 18 and start.minute > 0):
        raise ValueError("You can't start out of hours!")

    # Wind the clock back to 9am Monday
    minutes += start.weekday() * 9 * 60 + (start.hour-9) * 60 + start.minute
    monday=start - timedelta(days=start.weekday()) - \
                             timedelta(hours=start.hour-9) - \
                                       timedelta(minutes=start.minute)

    # Split the time to go forward into days and minutes
    days, minutes = divmod(minutes, 9*60)

    # For every whole 5 days, we need to add the two weekend days
    days += 2 * (days // 5)

    # Add the offset from 9am Monday, and print the answer
    end=monday + timedelta(days=days) + timedelta(minutes=minutes)
    print(end.strftime('%Y-%m-%d %H:%M'))


if __name__ == '__main__':
    main(sys.argv[1], float(sys.argv[2]))
