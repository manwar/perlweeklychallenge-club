# ===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge #120
#               Task 2 - Clock Angle
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 20210710 04:44:33 PM
# ===============================================================================


def calc_angle(what: str):

    hour, minute = map(int, what.split(':'))

    # each minute is 6 degrees
    angle_min = 6 * minute

    # hour hand has moved 30 * whole hours + 0.5 * mins
    angle_hour = 30 * hour + 0.5 * minute

    result_angle = abs(angle_hour - angle_min)

    # the challenge is asking for the smaller angle
    if result_angle > 180:
        return 360-result_angle

    return result_angle


assert calc_angle("03:10") == 35
assert calc_angle("04:00") == 120
assert calc_angle("10:14") == 137
