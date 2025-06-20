from sys import argv
from datetime import date

dt = date(*map(int, argv[1].split('-')))
print(dt.timetuple().tm_yday)
