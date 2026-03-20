#!/usr/bin/env python3
"""
Challenge 017, Task 2: URL parsing

Create a script to parse URL and print the components of URL.
According to Wiki page, the URL syntax is as below:
scheme://authority/path?query#fragment

Author: Lubos Kolouch
"""

import unittest
from urllib.parse import urlparse


class URLComponents:
    """Container for URL components."""

    def __init__(
        self,
        scheme: str,
        netloc: str,
        path: str,
        params: str,
        query: str,
        fragment: str,
    ):
        self.scheme = scheme
        self.netloc = netloc
        self.path = path
        self.params = params
        self.query = query
        self.fragment = fragment

    def __repr__(self) -> str:
        return (
            f"URLComponents(scheme='{self.scheme}', netloc='{self.netloc}', "
            f"path='{self.path}', params='{self.params}', query='{self.query}', "
            f"fragment='{self.fragment}')"
        )

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, URLComponents):
            return False
        return (
            self.scheme == other.scheme
            and self.netloc == other.netloc
            and self.path == other.path
            and self.params == other.params
            and self.query == other.query
            and self.fragment == other.fragment
        )


def parse_url(url: str) -> URLComponents:
    """
    Parse a URL and return its components.

    Args:
        url: The URL to parse

    Returns:
        URLComponents object with all parts

    Examples:
        >>> comps = parse_url("http://www.example.com/path?query=value#frag")
        >>> comps.scheme
        'http'
        >>> comps.netloc
        'www.example.com'
    """
    parsed = urlparse(url)

    return URLComponents(
        scheme=parsed.scheme,
        netloc=parsed.netloc,
        path=parsed.path,
        params=parsed.params,
        query=parsed.query,
        fragment=parsed.fragment,
    )


def print_url_components(url: str) -> None:
    """
    Print formatted URL components.

    Args:
        url: The URL to print components for
    """
    comps = parse_url(url)

    print(f"URL: {url}")
    print("-" * 40)
    print(f"Scheme   : {comps.scheme}")
    print(f"Netloc   : {comps.netloc}")
    print(f"Path     : {comps.path}")
    print(f"Params   : {comps.params}")
    print(f"Query    : {comps.query}")
    print(f"Fragment : {comps.fragment}")


def main() -> None:
    """Main function to demonstrate URL parsing."""
    test_urls = [
        "http://www.example.com/path?query=value#frag",
        "https://github.com/LubosKolouch/perlweeklychallenge-club",
        "ftp://files.example.com/docs/readme.txt",
        "http://localhost:8080/api/v1/users?id=123",
        "https://en.wikipedia.org/wiki/URL#Syntax",
    ]

    for url in test_urls:
        print_url_components(url)
        print()


if __name__ == "__main__":
    main()


class TestURLParsing(unittest.TestCase):
    """Unit tests for URL parsing."""

    def test_simple_http(self):
        """Test simple HTTP URL."""
        comps = parse_url("http://www.example.com")
        self.assertEqual(comps.scheme, "http")
        self.assertEqual(comps.netloc, "www.example.com")
        self.assertEqual(comps.path, "")

    def test_https_with_path(self):
        """Test HTTPS URL with path."""
        comps = parse_url("https://github.com/user/repo")
        self.assertEqual(comps.scheme, "https")
        self.assertEqual(comps.netloc, "github.com")
        self.assertEqual(comps.path, "/user/repo")

    def test_query_string(self):
        """Test URL with query string."""
        comps = parse_url("http://example.com/search?q=test")
        self.assertEqual(comps.query, "q=test")

    def test_fragment(self):
        """Test URL with fragment."""
        comps = parse_url("http://example.com/page#section")
        self.assertEqual(comps.fragment, "section")

    def test_full_url(self):
        """Test full URL with all components."""
        url = "http://user:pass@example.com:8080/path;params?q=1#frag"
        comps = parse_url(url)
        self.assertEqual(comps.scheme, "http")
        self.assertEqual(comps.netloc, "user:pass@example.com:8080")
        self.assertEqual(comps.path, "/path")
        self.assertEqual(comps.params, "params")
        self.assertEqual(comps.query, "q=1")
        self.assertEqual(comps.fragment, "frag")

    def test_empty_url(self):
        """Test empty path."""
        comps = parse_url("http://example.com/")
        self.assertEqual(comps.path, "/")

    def test_no_path(self):
        """Test URL without path."""
        comps = parse_url("http://example.com?query=1")
        self.assertEqual(comps.path, "")

    def test_ftp_url(self):
        """Test FTP URL."""
        comps = parse_url("ftp://files.example.com/docs")
        self.assertEqual(comps.scheme, "ftp")
        self.assertEqual(comps.netloc, "files.example.com")
        self.assertEqual(comps.path, "/docs")

    def test_localhost(self):
        """Test localhost URL."""
        comps = parse_url("http://localhost:3000/api")
        self.assertEqual(comps.scheme, "http")
        self.assertEqual(comps.netloc, "localhost:3000")
        self.assertEqual(comps.path, "/api")

    def test_equality(self):
        """Test URLComponents equality."""
        comps1 = parse_url("http://example.com/path")
        comps2 = parse_url("http://example.com/path")
        self.assertEqual(comps1, comps2)


if __name__ == "__main__":
    unittest.main()
