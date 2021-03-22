use Test2::V0;

use Sub::WrapInType::Attribute check => 0;

sub a :WrapSub([] => []) { 123 }

ok lives { a(321) }, 'invalid args';
ok lives { a() }, 'invalid returns';

done_testing;
