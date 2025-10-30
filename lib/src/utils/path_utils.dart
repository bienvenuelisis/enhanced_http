extension PathUtils on String? {
  /// Adds a leading slash to the path if it doesn't already have one.
  String? get withLeadingSlash {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.startsWith('/')) {
      return this;
    } else {
      return '/$this';
    }
  }

  /// Adds a trailing slash to the path if it doesn't already have one.
  String? get withoutTrailingSlash {
    if (this == null || this!.isEmpty) {
      return null;
    }

    return this!.endsWith('/') ? this!.substring(0, this!.length - 1) : this;
  }

  /// Adds a trailing slash to the path if it doesn't already have one.
  String? get withTrailingSlash {
    if (this == null || this!.isEmpty) {
      return null;
    }

    return this!.endsWith('/') ? this : '$this/';
  }
}
