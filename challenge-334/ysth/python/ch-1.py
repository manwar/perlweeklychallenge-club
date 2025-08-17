import sys
import json
import jsonschema

def range_sum(ints: list[int], x: int, y: int) -> int:
    sum = 0
    if x < 0 or y < x or y >= len(ints):
        raise Exception("index out of range")
    for i in range(x,y+1):
        sum += ints[i]
    return sum

def main() -> None:
    validator = jsonschema.Draft202012Validator({
        "type": "object",
        "properties": {
            "x": {"type": "integer"},
            "y": {"type": "integer"},
            "points": {
                "type": "array",
                "items": { "type": "integer" },
            },
        },
        "required": {"ints","x","y"},
    })

    inputs: list[str] = sys.argv[1:]

    for input_string in inputs:
        try:
            input_object = json.loads(input_string)
        except Exception as inst:
            print(inst)
            continue
        try:
            validator.validate(input_object)
        except jsonschema.exceptions.ValidationError as inst:
            print(inst.message)
            continue

        result = range_sum(**input_object)
        print(f'{input_string:<30} -> {result}')

if __name__ == '__main__':
    main()
