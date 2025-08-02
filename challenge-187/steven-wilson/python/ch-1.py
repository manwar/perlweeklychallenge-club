#!/usr/bin/env python3

MONTHS = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December"
}

DAYS_IN_MONTH = {
    "January": 31,
    "February": 28,
    "March": 31,
    "April": 30,
    "May": 31,
    "June": 30,
    "July": 31,
    "August": 31,
    "September": 30,
    "October": 31,
    "November": 30,
    "December": 31
}


def get_days(start, end):
    '''
    Given start date and end date in format "DD-MM" return a list of days in
    format "DD-MM".
    >>> get_days('12-01', '15-01')
    ['12-01', '13-01', '14-01', '15-01']
    >>> get_days('27-02', '01-03')
    ['27-02', '28-02', '01-03']
    >>> get_days('31-01', '01-03')
    ['31-01', '01-02', '02-02', '03-02', '04-02', '05-02', '06-02', '07-02', '08-02', '09-02', '10-02', '11-02', '12-02', '13-02', '14-02', '15-02', '16-02', '17-02', '18-02', '19-02', '20-02', '21-02', '22-02', '23-02', '24-02', '25-02', '26-02', '27-02', '28-02', '01-03']
    '''
    days = []
    (start_day, start_month) = (int(x) for x in start.split('-'))
    (end_day, end_month) = (int(x) for x in end.split('-'))

    if start_month == end_month:
        days.extend(f"{x:02d}-{start_month:02d}" for x in range(start_day, end_day+1))
    else:
        current_month = start_month
        days.extend(
            f"{x:02d}-{current_month:02d}" for x in range(
                start_day, DAYS_IN_MONTH[MONTHS[f"{current_month:02d}"]] + 1
            )
        )
        current_month += 1
        while current_month != end_month:
            days.extend(
                f"{x:02d}-{current_month:02d}" for x in range(
                    1, DAYS_IN_MONTH[MONTHS[f"{current_month:02d}"]] + 1
                )
            )
            current_month += 1
        days.extend(f"{x:02d}-{current_month:02d}" for x in range(1, end_day + 1))

    return days


def days_together(foo, bar):
    ''' Two friends, Foo and Bar gone on holidays seperately to the same city.
    You are given their schedule i.e. start date and end date.  To keep the
    task simple, the date is in the form DD-MM and all dates belong to the same
    calendar year i.e. between 01-01 and 31-12. Also the year is non-leap year
    and both dates are inclusive.  Find out for the given schedule, how many
    days they spent together in the city, if at all.

    >>> days_together({'sd': '12-01', 'ed': '20-01'}, {'sd': '15-01', 'ed': '18-01'})
    4
    >>> days_together({'sd': '02-03', 'ed': '12-03'}, {'sd': '13-03', 'ed': '14-03'})
    0
    >>> days_together({'sd': '02-03', 'ed': '12-03'}, {'sd': '11-03', 'ed': '15-03'})
    2
    >>> days_together({'sd': '30-03', 'ed': '05-04'}, {'sd': '28-03', 'ed': '02-04'})
    4
    '''
    foo_days = get_days(foo['sd'], foo['ed'])
    bar_days = get_days(bar['sd'], bar['ed'])
    return len(set(foo_days).intersection(set(bar_days)))


if __name__ == "__main__":
    import doctest

    doctest.testmod()
