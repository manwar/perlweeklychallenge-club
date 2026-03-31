
## Assumption:
## 1. Start Time of Event 2 >= Start Time of Event 1

## Example 1
## arrEvent_01 = ["10:00", "12:00"]
## arrEvent_02 = ["11:00", "13:00"]

## Example 2
## arrEvent_01 = ["09:00", "10:30"]
## arrEvent_02 = ["10:30", "12:00"]

## Example 3
## arrEvent_01 = ["14:00", "15:30"]
## arrEvent_02 = ["14:30", "16:00"]

## Example 4
## arrEvent_01 = ["08:00", "09:00"]
## arrEvent_02 = ["09:01", "10:00"]

## Example 5
arrEvent_01 = ["23:30", "00:30"]
arrEvent_02 = ["00:00", "01:00"]

print (arrEvent_02[0] < arrEvent_01[1])
