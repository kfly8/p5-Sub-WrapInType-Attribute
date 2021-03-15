package Sub::WrapInType::Attribute::Installer;
use v5.10.0;
use strict;
use warnings;

our $VERSION = "0.01";

use Sub::WrapInType ();
use Sub::Util ();
use attributes;

sub install {
    my $class = shift;
    my ($options, $pkg, $symbol, $code, $attr, $data) = @_;

    my $typed_code = Sub::WrapInType->new(
        params  => $data->[0],
        isa     => $data->[1],
        code    => $code,
        options => $options,
    );

    if (my @attr = attributes::get($code)) {
        no warnings qw(misc);
        attributes->import($pkg, $typed_code, @attr);
    }

    my $prototype = Sub::Util::prototype($code);
    Sub::Util::set_prototype($prototype, $typed_code);
    Sub::Util::set_subname(Sub::Util::subname($code), $typed_code);

    {
        no strict qw(refs);
        no warnings qw(redefine);
        *$symbol = $typed_code;
    }
    return;
}

1;
