import re

# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK1

def match_string(words: list[str]) -> list[str]:
    result: list[str] = []
    found: set[str] = set()
    for i, s in enumerate(words):
        if s in found:
            continue
        for j, s2 in enumerate(words):
            if i != j and s2.find(s) >= 0:
                found.add(s)
                result.append(s)
                break

    return result


if __name__ == "__main__":
    import run_weeklychallenge as run
    from typing import cast

    run.run_weekly_challenge(
        lambda inputs: '('+', '.join('"'+s+'"' for s in match_string(cast(list[str], inputs)))+')',
        '["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]',
        '{"type":"array", "items": {"type": "string"}}',
    )
