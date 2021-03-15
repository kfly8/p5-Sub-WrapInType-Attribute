package Sub::WrapInType::Attribute;
use v5.10.0;
use strict;
use warnings;

our $VERSION = "0.01";

use Attribute::Handlers;
use B::Hooks::EndOfScope;
use Sub::WrapInType::Attribute::Installer;
use namespace::autoclean;

my $DEFAULT_CHECK = !!($ENV{SUB_WRAPINTYPE_ATTRIBUTE_CHECK} // 1);
my %CHECK;

sub import {
    my $class = shift;
    my %args = @_;

    my $pkg = $args{pkg} ? $args{pkg} : scalar caller;
    $CHECK{$pkg} = !!$args{check} if exists $args{check};
    {
        # allow importing package to use attribute
        no strict 'refs';
        push @{"${pkg}::ISA"}, $class;
    }
    return;
}

sub WrapSub :ATTR(CODE,BEGIN) {
    my ($pkg, @args) = @_;

    my $opts = {
        check => $CHECK{$pkg} // $DEFAULT_CHECK,
        skip_invocant => 0,
    };

    on_scope_end {
        Sub::WrapInType::Attribute::Installer->install($opts, $pkg, @args);
    };
    return;
}

sub WrapMethod :ATTR(CODE,BEGIN) {
    my ($pkg, @args) = @_;

    my $opts = {
        check => $CHECK{$pkg} // $DEFAULT_CHECK,
        skip_invocant => 1,
    };

    on_scope_end {
        Sub::WrapInType::Attribute::Installer->install($opts, $pkg, @args);
    };
    return;
}

1;
__END__

=encoding utf-8

=head1 NAME

Sub::WrapInType::Attribute - attribute for Sub::WrapInType

=head1 SYNOPSIS

    use Sub::WrapInType::Attribute;
    use Types::Standard -types;

    sub hello :WrapSub([Str] => Str) {
        my $message = shift;
        return "HELLO $message";
    }

    hello('world!!'); # => HELLO world!!
    my $code = \&hello; # => Sub::WrapInType object

=head1 DESCRIPTION

This module provides attribute for Sub::WrapInType, which makes it easier to check during the compilation phase.

=head1 SEE ALSO

L<Sub::WrapInType>

=head1 LICENSE

Copyright (C) kfly8.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

kfly8 E<lt>kfly@cpan.orgE<gt>

=cut

