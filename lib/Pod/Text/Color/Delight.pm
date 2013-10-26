package Pod::Text::Color::Delight;
use 5.008005;
use strict;
use warnings;
use Term::ANSIColor qw(colored);
use File::Spec::Functions qw(catfile);
use Syntax::Highlight::Perl::Improved;
use parent 'Pod::Text::Color';

our $VERSION = '0.01';

use constant COLOR_TABLE => {
    code => {
        Character         => 'cyan',
        String            => 'rgb542',
        Quote             => 'rgb542',
        Label             => 'rgb542',

        Builtin_Function  => 'bright_red',
        Builtin_Operator  => 'bright_red',

        Keyword           => 'bright_red',
        Package           => 'rgb345',

        Subroutine        => 'rgb454',
        Bareword          => 'white',
        Symbol            => 'white',
        Operator          => 'white',
        Number            => 'white',

        Variable_Hash     => 'rgb520',
        Variable_Array    => 'rgb520',
        Variable_Scalar   => 'rgb520',
        Variable_Typeglob => 'rgb520',

        Comment_Normal    => 'grey10',
        Comment_POD       => 'grey10',
        DATA              => 'grey10',
        Directive         => 'bright_green',
    },
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

    my $color_table = COLOR_TABLE->{code};
    my $color_table_file = catfile($ENV{HOME}, '.pod_text_color_delight');
    if (!$ENV{POD_TEXT_COLOR_DELIGHT_DEFAULT} && -f $color_table_file) {
        $color_table = (do $color_table_file)->{code};
    }

    while (my ($type, $style) = each %{$color_table}) {
        $formatter->set_format($type, [Term::ANSIColor::color($style), Term::ANSIColor::color('reset')]);
    }

    return $formatter->format_string($text);
}

1;
__END__

=encoding utf-8

=head1 NAME

Pod::Text::Color::Delight - Delight Light Highlight the POD

=head1 SYNOPSIS

    use Pod::Text::Color::Delight;

    my $parser = Pod::Text::Color::Delight->new;
    $parser->parse_from_filehandle("/path/to/your.pod");

=head1 DESCRIPTION

Pod::Text::Color::Delight is a subclass of L<Pod::Text::Color> that highlights the pod text by using ANSI color escape.

Highlight of this module is a little radical in comparison with parent. For example, this module highlights headlines, links, and other several elements.
Additionally, this module also highlights Perl code (e.g. SYNOPSIS).

Basic usage is the same as L<Pod::Text::Color>. So please refer it.

=head1 CONFIGURATION AND ENVIRONMENT

=begin html

You can configure color codes for the code section.
What is necessary is just to put a F<.pod_text_color_delight> (it is configuration file) on your home directory.
The example of a configuration file should look at <a href="https://github.com/moznion/Pod-Text-Color-Delight/blob/master/eg/pod_text_color_delight.sample">pod_text_color_delight.sample</a> .

=end html


If you want to force the default settings, please set true value into B<POD_TEXT_COLOR_DELIGHT_DEFAULT> of environment variable.

=head1 REQUIREMENTS

This module requires the terminal which is able to use 256 colors. If you use the terminal that does not meet the conditions,
this module will not highlight texts completely.

=head1 SEE ALSO

L<Pod::Text>, L<Pod::Text::Color>

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion E<lt>moznion@gmail.comE<gt>

=cut
