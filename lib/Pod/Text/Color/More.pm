package Pod::Text::Color::More;
use 5.008005;
use strict;
use warnings;
use Term::ANSIColor qw(colored);
use Syntax::Highlight::Perl::Improved;
use parent 'Pod::Text::Color';

our $VERSION = '0.01';

use constant COLOR_TABLE => {
    'Bareword'          => 'bright_green',
    'Builtin_Function'  => 'blue',
    'Builtin_Operator'  => 'bright_red',
    'Character'         => 'bold bright_red',
    'Comment_Normal'    => 'bright_blue',
    'Comment_POD'       => 'bright_black',
    'Directive'         => 'bold bright_black',
    'Keyword'           => 'white',
    'Label'             => 'bright_magenta',
    'Line'              => 'white',
    'Number'            => 'bright_red',
    'Operator'          => 'white',
    'Package'           => 'bold bright_red',
    'Quote'             => 'blue',
    'String'            => 'blue',
    'Subroutine'        => 'yellow',
    'Symbol'            => 'white',
    'Variable_Array'    => 'cyan',
    'Variable_Hash'     => 'magenta',
    'Variable_Scalar'   => 'green',
    'Variable_Typeglob' => 'bright_red',
};

sub cmd_head1 {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_head1($attrs, colored($text, 'cyan'));
}

sub cmd_f {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_f($attrs, colored($text, 'bright_green'));
}

sub cmd_c {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_c($attrs, $self->_highlight_code($attrs, $text));
}

sub cmd_i {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_i($attrs, colored($text, 'reset italic'));
}

sub cmd_l {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_l($attrs, colored($text, 'blue'));
}

sub cmd_verbatim {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_verbatim($attrs, $self->_highlight_code($attrs, $text));
}

sub _highlight_code {
    my ($self, $attrs, $text) = @_;

    my $formatter = Syntax::Highlight::Perl::Improved->new;

    my $color_table = COLOR_TABLE;
    while (my ($type, $style) = each %{$color_table}) {
        $formatter->set_format($type, [Term::ANSIColor::color($style), Term::ANSIColor::color('reset')]);
    }

    return $formatter->format_string($text);
}

1;
__END__

=encoding utf-8

=head1 NAME

Pod::Text::Color::More - It's new $module

=head1 SYNOPSIS

    use Pod::Text::Color::More;
    say 'Hello';

=head1 DESCRIPTION

Pod::Text::Color::More is ...

=head1 SEE ALSO

L<Pod::Text>

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion E<lt>moznion@gmail.comE<gt>

=cut
