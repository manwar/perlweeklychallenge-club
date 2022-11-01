import sys

if len(sys.argv) != 2:
  sys.stderr.write('No arg(s) provided!')
  exit(1)

def is_leap_year(year):
  if year % 100 == 0: return year % 400 == 0
  return year % 4 == 0

def last_sunday(year):
  days = [31,28,31,30,31,30,31,31,30,31,30,31]
  if is_leap_year(year): days[1] = 29
  week = year * 365 + 97 * (year-1) + 4
  for month in range(0, len(days)):
    week = (week + days[month]) % 7
    print(f"{year}-{month+1:02d}-{days[month] - week}")
    
last_sunday(int(sys.argv[1]))
