### https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
"""

Task 1: Banking Day Offset

Submitted by: [42]Lee Johnson
     __________________________________________________________________

   You are given a start date and offset counter. Optionally you also get
   bank holiday date list.

   Given a number (of days) and a start date, return the number (of days)
   adjusted to take into account non-banking days. In other words: convert
   a banking day offset to a calendar day offset.

   Non-banking days are:
a) Weekends
b) Bank holidays

Example 1

Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
Output: '2018-07-04'

Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)

Example 2

Input: $start_date = '2018-06-28', $offset = 3
Output: '2018-07-03'

Task 2: Line Parser
"""
### solution by pokgopun@gmail.com

from datetime import date,datetime,timedelta

def str2date(datestr: str):                                      ### convert date string to date object
    return datetime.strptime(datestr,"%Y-%m-%d").date()

def isWeekday(d: date):                                          ### check if date object is a weekday, that is less than Saturday (i.e. 5 in python)
    return d.weekday() < 5 

def BDO(start: str, ofst: int, hols: tuple = ()):
    dstart = str2date(start)
    if isWeekday(dstart) == False:                               ### if startdate is a weekend day, move back to last friday
        dstart -= timedelta(days = dstart.weekday() - 4)         ### move back number of day from friday

    ### convert weekday offset (ofst) to everyday offset (dur), that is 7 * number of week (i.e. ofset // 5) and the remaing partial-weekday offset (ofst % 5)
    dur = timedelta(days = 7*(ofst // 5) + ofst % 5)
    ### now we need to account for partial-weekday offset in the everyday offset
    if dstart.weekday() + ofst % 5 > 4:                          ### if partial-weekday offset move startdate over the current weekday, add weekend offset to everyday offset
        dur += timedelta(days=2)
    dend = dstart + dur                                          ### calculate enddate

    ### now account for holidays one by one, need to start from the earliest holiday first so we sort holidays before processing
    for hol in sorted(set(hols)):
        dhol = str2date(hol)
        if dhol > dstart and dhol <= dend and isWeekday(dhol):   ### only offset holiday if it is a weekday and is later than startdate but not later than current enddate
            dend += timedelta(days=1)
            if isWeekday(dend) == False:                         ### if a holiday offset move enddate to a weekend day, add weekend offset
                dend += timedelta(days=2)                        ### this is ok as we account for holiday offset one by one
    return dend.strftime("%Y-%m-%d")

import unittest

class TestBDO(unittest.TestCase):
    def test(self):
        for output, (start_date, offset, bank_holidays) in {
                "2018-07-04": ("2018-06-28", 3, ("2018-07-03",)),
                "2018-07-03": ("2018-06-28", 3, ()),
                "2018-07-05": ("2018-06-28", 3, ("2018-07-02", "2018-07-03")),
                "2018-07-05": ("2018-06-28", 3, ("2018-07-06", "2018-07-03", "2018-07-02")),
                "2018-07-06": ("2018-06-28", 3, ("2018-07-02", "2018-07-03", "2018-07-05")),
                "2018-07-06": ("2018-06-28", 3, ("2018-07-02", "2018-07-03", "2018-07-05","2024-03-05")),
                "2018-07-06": ("2018-06-28", 3, ("2018-07-02", "2018-07-03", "2018-07-05","1979-07-09")),
                "2018-07-13": ("2018-06-28", 8, ("2018-07-02", "2018-07-03", "2018-07-05","1979-07-09")),
                "2018-07-16": ("2018-06-28", 9, ("2018-07-02", "2018-07-03", "2018-07-05","1979-07-09")),
                "2018-07-23": ("2018-06-28", 14, ("2018-07-02", "2018-07-03", "2018-07-05","1979-07-09")),
                "2018-07-25": ("2018-06-28", 14, ("2018-07-02", "2018-07-03", "2018-07-05","2018-07-11","2018-07-18")),
                "2018-07-05": ("2018-06-29", 3, ("2018-07-03",)),
                "2018-07-05": ("2018-06-30", 3, ("2018-07-03",)),
                }.items():
            self.assertEqual(output, BDO(start_date, offset, bank_holidays))

unittest.main()
