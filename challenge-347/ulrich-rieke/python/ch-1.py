import re

def parseDate( date ):
    grp = re.search(r'^([1-3]?\d)[rdsthn]{2}\s(\w{3})\s([12][091]\d{2})$' , date ) ;
    months = ["Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , 
     "Oct" , "Nov" , "Dec"] ;
    (day , month , year ) = grp.groups( ) ;
    if len(day) == 1:
        day = '0' + day
    monthindex = months.index( month ) + 1
    mi = str(monthindex) ;
    if monthindex < 10:
        mi = '0' + mi
    result = year + '-' + mi + '-' + day
    return result

print( parseDate("1st Jan 2025"))
print( parseDate("22nd Feb 2025"))
print( parseDate("15th Apr 2025"))
print( parseDate("23rd Oct 2025"))
print( parseDate("31st Dec 2025"))
       

