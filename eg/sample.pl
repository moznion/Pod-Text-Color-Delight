#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Pod::Text::Color::More;

my $parser = Pod::Text::Color::More->new;
$parser->parse_from_filehandle("$FindBin::Bin/../lib/Pod/Text/Color/More.pm");
