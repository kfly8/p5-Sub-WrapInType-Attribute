use Test2::V0;

BEGIN {
    $ENV{SUB_WRAPINTYPE_ATTRIBUTE_CHECK} = 0;
}
use Sub::WrapInType::Attribute;

sub a :WrapSub([] => []) { 123 }

ok lives { a(321) }, 'invalid args';
ok lives { a() }, 'invalid returns';

done_testing;
