import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK2

def meeting_point(instructions: str) -> bool:
    """
    Parameters:
    instructions: string of U/L/D/R characters indicating movement

    Return true if movement returns to origin at any step, otherwise false
    """
    x: int = 0
    y: int = 0
    met_origin: bool = False
    for c in instructions:
        if c == 'U':
            x += 1
        elif c == 'D':
            x -= 1
        elif c == 'R':
            y += 1
        elif c == 'L':
            y -= 1
        if x == 0 and y == 0:
            met_origin = True
            break

    return met_origin

if __name__ == '__main__':
    import run_weeklychallenge as run
    run.run_weekly_challenge(lambda inputs: 'true' if meeting_point(str(inputs)) else 'false', '"ULD"', '{"type":"string","pattern":"^[UDRL]*$"}')
