from typing import List, Tuple


def minutes_light_on(guest_book: List[Tuple[str, str, str]]) -> int:
    """
    Calculate the total minutes the light was on based on the guest book entries.

    :param guest_book: A list of tuples containing guest names, IN time, and OUT time.
    :return: The total minutes the light was on.
    """
    time_ranges = []
    for _, in_time, out_time in guest_book:
        in_time_minutes = int(in_time.split(":")[0]) * 60 + int(in_time.split(":")[1])
        out_time_minutes = int(out_time.split(":")[0]) * 60 + int(
            out_time.split(":")[1]
        )
        time_ranges.append((in_time_minutes, out_time_minutes))

    time_ranges.sort()

    merged_ranges = [time_ranges[0]]
    for current_start, current_end in time_ranges[1:]:
        last_start, last_end = merged_ranges[-1]

        if current_start > last_end:
            merged_ranges.append((current_start, current_end))
        else:
            merged_ranges[-1] = (last_start, max(current_end, last_end))

    total_minutes = sum(end - start for start, end in merged_ranges)

    return total_minutes


def test_minutes_light_on():
    guest_book = [
        ("Alex", "09:10", "09:45"),
        ("Arnold", "09:15", "09:33"),
        ("Bob", "09:22", "09:55"),
        ("Charlie", "09:25", "10:05"),
        ("Steve", "09:33", "10:01"),
        ("Roger", "09:44", "10:12"),
        ("David", "09:57", "10:23"),
        ("Neil", "10:01", "10:19"),
        ("Chris", "10:10", "11:00"),
    ]
    assert minutes_light_on(guest_book) == 110
