#!/usr/bin/env python3
"""Challenge 100, Task 1"""

import re
import sys
from datetime import datetime


DEFAULT_INPUT = '05:15pm'
TIME_RE = re.compile(r"""
        \A
        \s*(?P<hhmm>\d{1,2}:\d{1,2})
        \s*(?P<ampm>[ap]\.?m\.?)?
        \s*
        \Z
        """, re.I | re.X)
FMT = {
        '12h': { 'parse': "%I:%M%p", 'out': '%H:%M'   },
        '24h': { 'parse': "%H:%M",   'out': "%I:%M%p" },
      }


def fun_time(timestr):
    """Convert the given time from 12 hour format to 24 hour format and vice
    versa."""

    if (m := TIME_RE.match(timestr)):
        mgroup = m.groupdict()
        fmt = FMT['12h'] if mgroup['ampm'] else FMT['24h']
        new_timestr = mgroup['hhmm'] + str(mgroup['ampm'] or '')
        time = datetime.strptime(new_timestr, fmt['parse'])
        return time.strftime(fmt['out'])


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    timestr = args[0] if args else DEFAULT_INPUT
    print(fun_time(timestr))


if __name__ == '__main__':
    sys.exit(main())
