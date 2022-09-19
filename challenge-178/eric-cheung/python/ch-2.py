
###
from datetime import timedelta, date

class BusDate():

    def __init__(self, nYear, nMonth, nDay, nHour, nMin):
        self.BusDate = date(nYear, nMonth, nDay)
        self.BusHour = nHour
        self.BusMin = nMin

    def AddHour(self, dHourAdd):

        nHourAdd = int(dHourAdd)
        nMinAdd = int((dHourAdd - nHourAdd) * 60)

        self.BusHour = self.BusHour + nHourAdd
        self.BusMin = self.BusMin + nMinAdd

        if self.BusMin >= 60:
            self.BusMin = self.BusMin - 60
            self.BusHour = self.BusHour + 1

        while (self.BusHour > 18 or self.BusHour == 18 and self.BusMin > 0):
            self.BusHour = self.BusHour - 9
            self.BusDate = self.BusDate + timedelta(days = 1)
            if (self.BusDate.weekday() == 5):
                self.BusDate = self.BusDate + timedelta(days = 2)
            elif (self.BusDate.weekday() == 6):
                self.BusDate = self.BusDate + timedelta(days = 1)

        return self.BusDate.strftime("%Y-%m-%d") + " " + ("0" + str(self.BusHour) if self.BusHour < 10 else str(self.BusHour)) + ":" + ("0" + str(self.BusMin) if self.BusMin < 10 else str(self.BusMin))


### Example 1
## objInputDate = BusDate(2022, 8, 1, 10, 30)
## print (objInputDate.AddHour(4))


### Example 2
objInputDate = BusDate(2022, 8, 1, 17, 0)
print (objInputDate.AddHour(3.5))

