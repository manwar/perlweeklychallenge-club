#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, VecDeque};

#[derive(PartialEq, Debug)]
pub struct Lump {
    id: String,
    fields: HashMap<String, String>,
}

#[test]
fn test_ex1() {
    assert_eq!(
        lineparser(
            "{%  id   field1=\"value1\"    field2=\"value2\"  field3=42 %}"
        ),
        Lump {
            id: "id".to_string(),
            fields: HashMap::from([
                ("field3".to_string(), "42".to_string()),
                ("field2".to_string(), "value2".to_string()),
                ("field1".to_string(), "value1".to_string())
            ])
        }
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        lineparser("{%  youtube title=\"Title \\\"quoted\\\" done\" %}"),
        Lump {
            id: "youtube".to_string(),
            fields: HashMap::from([(
                "title".to_string(),
                "Title \"quoted\" done".to_string()
            )])
        }
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        lineparser(
            "{%  youtube title=\"Title with escaped backslash \\\\\" %}"
        ),
        Lump {
            id: "youtube".to_string(),
            fields: HashMap::from([(
                "title".to_string(),
                "Title with escaped backslash \\".to_string()
            )])
        }
    );
}

#[derive(PartialEq, Debug)]
enum State {
    Outside,
    PreID,
    InID,
    InterField,
    FieldName,
    FieldValue,
    FieldValueQuoted,
}

fn lineparser(line: &str) -> Lump {
    let mut l = line.chars().collect::<VecDeque<_>>();
    let mut state = State::Outside;
    let mut trail: Vec<char> = Vec::new();
    let mut fieldname = "".to_string();
    let mut out = Lump { id: "".to_string(), fields: HashMap::new() };
    while l.len() > 0 {
        let mut c = l.pop_front().unwrap();
        if state == State::Outside && c == '{' {
            c = l.pop_front().unwrap();
            if c == '%' {
                state = State::PreID;
            }
        } else if (state == State::PreID || state == State::InID) && c != ' ' {
            trail.push(c);
            state = State::InID;
        } else if state == State::InID && c == ' ' {
            out.id = trail.into_iter().collect();
            trail = Vec::new();
            state = State::InterField;
        } else if (state == State::InterField || state == State::FieldName)
            && c != ' '
            && c != '='
            && c != '%'
        {
            trail.push(c);
            state = State::FieldName;
        } else if state == State::FieldName && c == '=' {
            fieldname = trail.into_iter().collect();
            trail = Vec::new();
            state = State::FieldValue;
        } else if state == State::FieldValue && trail.len() == 0 && c == '"' {
            state = State::FieldValueQuoted;
        } else if state == State::FieldValue || state == State::FieldValueQuoted
        {
            let mut literal = false;
            if c == '\\' {
                c = l.pop_front().unwrap();
                literal = true;
            }
            if (c == ' ' && state == State::FieldValue)
                || (c == '"' && state == State::FieldValueQuoted && !literal)
            {
                out.fields
                    .insert(fieldname.clone(), trail.into_iter().collect());
                trail = Vec::new();
                state = State::InterField;
            } else {
                trail.push(c);
            }
        }
    }
    out
}
