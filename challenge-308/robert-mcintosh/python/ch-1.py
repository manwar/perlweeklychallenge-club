def count_common(str1: [str], str2: [str]) -> int:
    return len(set(str1).intersection(set(str2)))
