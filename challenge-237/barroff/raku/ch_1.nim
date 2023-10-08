import std/[algorithm, sequtils, times, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc seize_the_day(year, month, wd, dow: int): int =
  let
    start_date = dateTime(year, Month(month), wd)
    week_shift = if weekday(start_date) > WeekDay(dow): 1 else: 2

  if wd == 1:
    if week_shift == 1:
      return 0
    else:
      return 1 + dow - int(weekday(start_date))

  let
    day_shift = days(int(high(WeekDay)) - int(weekday(start_date)) + (wd -
        week_shift) * 7 + dow)
    final_day = start_date + day_shift

  return if month(start_date) == month(final_day): int(monthday(
      final_day)) else: 0

suite "seize the day":
  test "(2024, 4, 3, 2)":
    let
      std = seize_the_day(2024, 4, 3, 2)

    check(std == 16)

  test "(2025, 10, 2, 4)":
    let
      std = seize_the_day(2025, 10, 2, 4)

    check(std == 9)

  test "(2026, 8, 5, 3)":
    let
      std = seize_the_day(2026, 8, 5, 3)

    check(std == 0)
