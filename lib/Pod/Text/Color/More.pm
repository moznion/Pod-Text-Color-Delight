package Pod::Text::Color::More;
use 5.008005;
use strict;
use warnings;
use Term::ANSIColor qw(colored);
use Syntax::Highlight::Perl::Improved;
use parent 'Pod::Text::Color';

our $VERSION = '0.01';

use constant COLOR_TABLE => {
    'Character'         => 'cyan',
    'String'            => 'rgb542',
    'Quote'             => 'rgb542',
    'Label'             => 'rgb542',

    'Builtin_Function'  => 'bright_red',
    'Builtin_Operator'  => 'bright_red',

    'Keyword'           => 'bright_red',
    'Package'           => 'rgb345',

    'Subroutine'        => 'rgb454',
    'Bareword'          => 'white',
    'Symbol'            => 'white',
    'Operator'          => 'white',
    'Number'            => 'white',

    'Variable_Hash'     => 'rgb520',
    'Variable_Array'    => 'rgb520',
    'Variable_Scalar'   => 'rgb520',
    'Variable_Typeglob' => 'rgb520',

    'Comment_Normal'    => 'grey10',
    'Comment_POD'       => 'grey10',
    'DATA'              => 'grey10',
    'Directive'         => 'bright_green',
};

sub cmd_head1 {
    my ($self, $attrs, $text) = @_;
    $self->SUPER::cmd_head1($attrs, colored($text, 'bright_cyan'));
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
    $self->SUPER::cmd_l($attrs, colored($text, 'rgb045'));
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
