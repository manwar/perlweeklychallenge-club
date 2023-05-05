#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
from typing import List


def email_sort_key(email: str) -> tuple:
    mailbox, domain = email.split('@')
    return (domain.lower(), mailbox)


def main(emails: List[str], unique: bool) -> None:
    if unique:
        emails = list(set(emails))

    sorted_emails = sorted(emails, key=email_sort_key)

    for email in sorted_emails:
        print(email)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-u',
                        '--unique',
                        action='store_true',
                        help='Only include unique email addresses')
    parser.add_argument('files',
                        nargs='*',
                        type=argparse.FileType('r'),
                        default=[sys.stdin])
    args = parser.parse_args()

    all_emails = [line.strip() for file in args.files for line in file]
    main(all_emails, args.unique)
