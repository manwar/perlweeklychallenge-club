import sys
input_date = sys.argv[1]

(y,m,d) = [ int(i) for i in input_date.split('-') ]
day_of_year = (
    (367*m - 362) // 12 + d
        - (0 if m<=2 else 1 if y%4==0 and y%100!=0 or y%400==0 else 2)
)
print(f'using calculation: {day_of_year}')

from datetime import date
try:
    print(f'using standard library: {date.fromisoformat(input_date).timetuple().tm_yday}')
except ValueError as inst:
    print(inst)
