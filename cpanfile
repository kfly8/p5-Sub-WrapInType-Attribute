requires 'perl', '5.014';

requires 'Attribute::Handlers';
requires 'B::Hooks::EndOfScope', '0.23';
requires 'Sub::WrapInType', '0.07';
requires 'Sub::Util';
requires 'namespace::autoclean';

on 'configure' => sub {
    requires 'Module::Build::Tiny', 0.035;
};

on 'test' => sub {
    requires 'Test2::V0', '0.000111';
};
