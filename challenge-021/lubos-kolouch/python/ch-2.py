#!/usr/bin/env python3
"""
Challenge 021 - Task 2: URL Normalization

Write a script for URL normalization based on RFC 3986.

URL normalization is the process by which URLs are modified and standardized
in a consistent manner. The main transformations include:
- Converting scheme and host to lowercase
- Removing default ports (80 for HTTP, 443 for HTTPS)
- Removing trailing slashes from paths (except for the root)
- Removing duplicate slashes
- Removing directory references (.) and parent directory references (..)
- Removing fragment identifiers (#)
- Sorting query parameters
- Removing empty query parameters
"""

from urllib.parse import urlparse, urlunparse, quote, unquote


def normalize_url(url: str) -> str:
    """
    Normalize a URL according to RFC 3986.

    Args:
        url: The URL to normalize

    Returns:
        The normalized URL
    """
    # Parse the URL into components
    parsed = urlparse(url)

    # Get each component
    scheme = parsed.scheme.lower()
    netloc = parsed.netloc.lower()
    path = parsed.path
    params = parsed.params
    query = parsed.query
    fragment = parsed.fragment

    # Remove default ports
    if scheme == "http" and netloc.endswith(":80"):
        netloc = netloc[:-3]
    elif scheme == "https" and netloc.endswith(":443"):
        netloc = netloc[:-4]

    # Remove fragment
    fragment = ""

    # Normalize path
    if path:
        # Decode percent-encoded characters
        path = unquote(path)

        # Remove duplicate slashes
        while "//" in path:
            path = path.replace("//", "/")

        # Remove trailing slash (except for root)
        if path != "/" and path.endswith("/"):
            path = path.rstrip("/")

        # Remove . and .. from path
        segments = path.split("/")
        normalized_segments = []

        for segment in segments:
            if segment == "..":
                if normalized_segments:
                    normalized_segments.pop()
            elif segment != "." and segment:
                normalized_segments.append(segment)

        path = "/" + "/".join(normalized_segments) if normalized_segments else "/"

        # Re-encode special characters
        path = quote(path, safe="/@!$&'()*+,;=")

    # Handle query string
    if query:
        # Parse and sort query parameters
        params_dict = {}
        for param in query.split("&"):
            if "=" in param:
                key, value = param.split("=", 1)
                params_dict[unquote(key)] = unquote(value)
            elif param:
                params_dict[unquote(param)] = ""

        # Remove empty parameters and sort
        params_dict = {k: v for k, v in params_dict.items() if k}

        # Rebuild query string
        query_parts = []
        for key in sorted(params_dict.keys()):
            if params_dict[key]:
                query_parts.append(f"{quote(key)}={quote(params_dict[key])}")
            else:
                query_parts.append(quote(key))

        query = "&".join(query_parts)

    # Rebuild the normalized URL
    # Add port back if it was removed
    if scheme == "http" and ":" in netloc and not netloc.endswith(":80"):
        pass  # Keep custom port
    elif scheme == "https" and ":" in netloc and not netloc.endswith(":443"):
        pass  # Keep custom port

    normalized = urlunparse((scheme, netloc, path, params, query, fragment))

    return normalized


def main():
    """Main function to normalize URLs from input."""
    test_urls = [
        "HTTP://www.Example.com/",
        "http://www.example.com:80/",
        "https://www.example.com:443/",
        "http://www.example.com///test//foo/../bar",
        "http://www.example.com/path?b=2&a=1&c=3",
        "HTTP://WWW.EXAMPLE.COM/",
        "http://example.com/index.html#section",
    ]

    print("URL Normalization Demo:")
    print("-" * 60)

    for url in test_urls:
        normalized = normalize_url(url)
        print(f"Original:    {url}")
        print(f"Normalized:  {normalized}")
        print()


if __name__ == "__main__":
    main()
