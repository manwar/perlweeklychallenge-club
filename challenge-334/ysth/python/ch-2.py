import sys
import json
import jsonschema

def nearest_valid_point(x: int, y: int, points: list[list[int]]) -> int:
    nearest_index = -1
    distance: int
    for i in range(len(points)):
        this_distance: int
        if points[i][0] == x:
            #print("x matches")
            this_distance = y - points[i][1]
        elif points[i][1] == y:
            #print("y matches")
            this_distance = x - points[i][0]
        else:
            continue
        #print(f'this distance {this_distance}')
        if this_distance < 0:
            this_distance = -this_distance
        #print(f'this distance {this_distance} nearest_index {nearest_index}')
        if nearest_index < 0 or this_distance < distance:
            #print('setting')
            distance = this_distance
            nearest_index = i
    return nearest_index

def main() -> None:
    validator = jsonschema.Draft202012Validator({
        "type": "object",
        "properties": {
            "x": {"type": "integer"},
            "y": {"type": "integer"},
            "points": {
                "type": "array",
                "items": {
                    "type": "array",
                    "prefixItems": [{"type": "integer"},{"type": "integer"}],
                    "minItems": 2,
                    "items": False,
                },
            },
        },
        "required": {"x","y","points"},
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

        result = nearest_valid_point(**input_object)
        print(f'{input_string:<30} -> {result}')

if __name__ == '__main__':
    main()
