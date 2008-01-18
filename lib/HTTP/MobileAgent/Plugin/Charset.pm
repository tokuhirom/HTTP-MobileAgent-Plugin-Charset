package HTTP::MobileAgent::Plugin::Charset;
use strict;
use warnings;
our $VERSION = '0.01';

sub HTTP::MobileAgent::can_display_utf8 {
    my $self = shift;
    $self->xhtml_compliant;
}
sub HTTP::MobileAgent::AirHPhone::can_display_utf8 {
    my $self = shift;
    $self->get_header('Accept-Charset') =~ /utf-?8/i ? 1 : 0;
}

sub HTTP::MobileAgent::encoding {
    my $self = shift;
    if ($self->is_non_mobile) {
        return 'utf-8';
    } elsif ($self->is_ezweb && !$self->can_display_utf8) {
        return 'x-sjis-ezweb-auto';
    } else {
        my $charset = $self->can_display_utf8 ? 'utf8' : 'sjis';
        return join '-', 'x', $charset, lc($self->carrier_longname);
    }
}

1;
__END__

=encoding utf8

=for stopwords aaaatttt dotottto gmail

=head1 NAME

HTTP::MobileAgent::Plugin::Charset - Encode::JP::Mobile friendly

=head1 SYNOPSIS

  use HTTP::MobileAgent;
  use HTTP::MobileAgent::Plugin::Charset;

  my $agent = HTTP::MobileAgent->new;
  $agent->can_display_utf8; # => 1 or 0

  use Encode::JP::Mobile;
  encode($agent->encoding, "\x{223e}");

=head1 DESCRIPTION

HTTP::MobileAgent::Plugin::Charset is a plugin of HTTP::MobileAgent.

You can detect encoding. The result can use with Encode::JP::Mobile.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom aaaatttt gmail dotottto commmmmE<gt>

=head1 SEE ALSO

L<HTTP::MobileAgent>, L<Encode::JP::Mobile>

L<http://www.au.kddi.com/ezfactory/tec/spec/wap_rule.html>
L<http://www.nttdocomo.co.jp/service/imode/make/content/xhtml/about/>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
