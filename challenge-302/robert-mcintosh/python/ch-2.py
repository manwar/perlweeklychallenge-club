def return_min_start(ints: list[int]) -> int | None:
    for start_value in range(1, 1000000):
        step_sum = start_value + ints[0]
        if step_sum < 1:
            continue
        for index in range(1, len(ints)):
            step_sum += ints[index]
            if step_sum < 1:
                break
        if step_sum >= 1:
            return start_value
    return None
