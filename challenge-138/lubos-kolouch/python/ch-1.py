import datetime


def get_work_days(what: int):
    """ Calculate the work days """

    dt_1_1 = datetime.date(what, 1, 1)
    dt_31_12 = datetime.date(what, 12, 31)

    weeks_in_year = dt_31_12.isocalendar()[1]
    if dt_1_1.isocalendar()[1] != 1:
        weeks_in_year += 1

    result = weeks_in_year * 5

    # deduct left over days at the end of the year
    result -= max(6 - dt_31_12.weekday() - 1, 0)

    # deduct days at the beginning of the year
    result -= min(dt_1_1.weekday() - 1, 6)

    return result


assert get_work_days(2021) == 261
assert get_work_days(2020) == 262
