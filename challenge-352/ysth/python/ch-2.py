import re
from typing import cast

# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK2

def binary_prefix(nums: list[int]) -> tuple[bool, ...]:
    return tuple(len(m) != 0 for m in re.findall(r'(?=((?:1(?:101*0)*(?:11|0)(?:01|001*0(?:101*0)*(?:11|0))*1|0)+\z|)).', ''.join(str(d) for d in nums[::-1])))[::-1]

if __name__ == "__main__":
    import run_weeklychallenge as run

    run.run_weekly_challenge(
        lambda inputs: str(binary_prefix(cast(list[int], inputs))).lower(),
        '[0,1,1,0,0,1,0,1,1,1]',
        '{"type":"array", "items": {"type": "integer", "minimum": 0, "maximum": 1}}',
    )

