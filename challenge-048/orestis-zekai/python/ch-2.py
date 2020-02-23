from datetime import date, timedelta

sdate = date(2000, 1, 1)
edate = date(2999, 12, 31)

delta = edate - sdate
c = 1
for i in range(delta.days + 1):
    day = sdate + timedelta(days=i)
    str_month = str(day.month)
    if (day.month < 10):
    	str_month = '0' + str_month
    str_day = str(day.day)
    if (day.day < 10):
    	str_day = '0' + str_day

    str_date = str_month + str_day + str(day.year)

    if (str_date == str_date[::-1]):
    	print(str(c) + ': Palindrome ' + str(day) + ' ( ' + str_date + ' )')
    	c += 1