base_year = 2000
days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def is_leap_year(year):
    if year % 400 == 0:
        return True
    if year % 100 == 0:
        return False
    if year % 4 == 0:
        return True
    return False

def weekday(year, month, day):
    year = int(year); month = int(month); day = int(day)
    skip_days = year - base_year
    for yr in range(base_year, year):
        if is_leap_year(yr):
            skip_days += 1
    if is_leap_year(year) and month > 2:
        skip_days += 1
    for m in range(1, 13):
        if m < month:
            skip_days += days_in_month[m - 1]
    skip_days += int(day) - 1
    days = ["sat", "sun", "mon", "tue", "wed", "thu", "fri"]
    return days[skip_days % 7]

def is_weekend(year, month, day):
    today = weekday(year, month, day)
    if today == "sat" or today == "sun":
        return True
    else:
        return False

def is_holiday(bank_holidays, year, month, day):
    for date in bank_holidays:
        (hol_year, hol_month, hol_day) = date.split("-")
        if year == hol_year and month == hol_month and day == hol_day:
            return True
    return False

def proc(start_date, offset, bank_holidays):
    (year, month, day) = start_date.split("-")
    (new_year, new_month, new_day) = (year, month, day)
    steps = offset
    while steps > 0:
        leap = 0
        if is_leap_year(int(year)) and month == "02":
            leap = 1
        if int(new_day) + 1 > leap + days_in_month[int(new_month)-1]:
            if new_month == "12":
                new_year = str(int(new_year) + 1)
            new_month = '{:02}'.format(int(new_month) + 1)
            if new_month == "13":
                new_month = "01"
            new_day = "01"
        else:
            new_day = '{:02}'.format(int(new_day) + 1)
        if not (is_holiday(bank_holidays, new_year, new_month, new_day) or is_weekend(new_year, new_month, new_day)):
            steps -= 1
    new_date = new_year + "-" + new_month + "-" + new_day
    print("Input:", start_date, "Offset:", offset, "Holidays: ", end='')
    for d in bank_holidays:
        print(d,'', end='')
    print("\nOutput:", new_date)

start_date = '2018-06-28'
offset = 3
bank_holidays = ["2018-07-03"]

proc(start_date, offset, bank_holidays)

