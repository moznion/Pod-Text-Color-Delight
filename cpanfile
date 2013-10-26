requires 'Pod::Text::Color';
requires 'Syntax::Highlight::Perl::Improved';
requires 'Term::ANSIColor';
requires 'parent';
requires 'perl', '5.008005';

on configure => sub {
    requires 'CPAN::Meta';
    requires 'CPAN::Meta::Prereqs';
    requires 'Module::Build';
};

on 'test' => sub {
    requires 'Test::More', '0.98';
};
