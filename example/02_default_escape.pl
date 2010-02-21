#!perl

use strict;
use warnings;

our $VERSION = 0;

use HTML::Template::Compiled;

my $htc = HTML::Template::Compiled->new(
    plugin         => [qw(HTML::Template::Compiled::Plugin::VBEscape)],
    tagstyle       => [qw(-classic -comment +asp)],
    default_escape => 'VB',
    scalarref      => \<<'EOVB');
<script language="VBScript"><!--
    string1 = "<%= attribute%>"
    string2 = "<%= cdata%>"
'--></script>
EOVB
$htc->param(
    attribute => 'foo "bar"',
    cdata     => 'text "with" double quotes',
);
() = print $htc->output();

# $Id$

__END__

Output:

<script language="VBScript"><!--
    string1 = "foo ""bar"""
    string2 = "text ""with"" double quotes"
'--></script>