
# NAME

Sub::WrapInType::Attribute - attribute for Sub::WrapInType

# SYNOPSIS

```perl
use Sub::WrapInType::Attribute;
use Types::Standard -types;

sub hello :WrapSub([Str] => Str) {
    my $message = shift;
    return "HELLO $message";
}

hello('world!!'); # => HELLO world!!
my $code = \&hello; # => Sub::WrapInType object
```

# DESCRIPTION

This module provides attribute for Sub::WrapInType, which makes it easier to check during the compilation phase.

# SEE ALSO

[Sub::WrapInType](https://metacpan.org/pod/Sub%3A%3AWrapInType)

# LICENSE

Copyright (C) kfly8.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

kfly8 <kfly@cpan.org>
