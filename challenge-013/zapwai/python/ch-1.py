def is_leap_year (year):
    if year % 400 == 0:
        return True
    if year % 100 == 0:
        return False
    if year % 4  == 0:
        return True
    return False

def days_to_date(days, year):
    if days > 365:
        return "erroneous number of days\n"
    days += 1
    d = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if is_leap_year(year) :
        d[1] += 1
    month = 0
    while days > d[month]:
        days -= d[month]
        month += 1
    month += 1
    mn = ""
    if month < 10:
        mn += "0"
    mn += str(month)
    dy = ""
    if days < 10:
        dy += "0"
        dy += str(days)
    else:
        dy += str(days)
    return mn+"-"+dy+"-"+str(year)

def fridays(year):
    day = [ "sat", "sun", "mon", "tue", "wed", "thu", "fri" ]
    base_year = 2000
    skip_days = year - base_year
    for yr in range(base_year, year) :
        if is_leap_year(yr):
            skip_days += 1
    first_fri_delta = 0
    while "fri" != day[((skip_days + first_fri_delta)%7)] :
        first_fri_delta += 1
    n = first_fri_delta
    last_fridays = []
    tmp = "01-01-1900"
    while n < 365:
        date = days_to_date(n, year)
        if tmp[0:2] != date[0:2]:
            last_fridays.append(tmp)
        n += 7
        tmp = date
    last_fridays.append(tmp)
    for w in last_fridays :
        print(w)

fridays(2024)
