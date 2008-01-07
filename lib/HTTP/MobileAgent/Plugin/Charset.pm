package HTTP::MobileAgent::Plugin::Charset;
use strict;
use warnings;
our $VERSION = '0.01';

# -------------------------------------------------------------------------
# docomo
sub HTTP::MobileAgent::DoCoMo::encoding {
    my $self = shift;
    $self->can_display_utf8 ? 'x-utf8-docomo' : 'x-sjis-docomo';
}
# http://www.nttdocomo.co.jp/service/imode/make/content/xhtml/about/
sub HTTP::MobileAgent::DoCoMo::can_display_utf8 {
    my $self = shift;
    $self->xhtml_compliant;
}

# -------------------------------------------------------------------------
# non-mobile
sub HTTP::MobileAgent::NonMobile::encoding { 'utf8' }
sub HTTP::MobileAgent::NonMobile::can_display_utf8 { 1 }

1;
__END__

=for stopwords aaaatttt dotottto gmail

=head1 NAME

HTTP::MobileAgent::Plugin::Charset - Encode::JP::Mobile friendly

=head1 SYNOPSIS

  use HTTP::MobileAgent;
  use HTTP::MobileAgent::Plugin::Charset;

  my $agent = HTTP::MobileAgent->new;
  $agent->can_display_utf8; # => 1 or 0
  decode($agent->encoding, $r->param('body'));

=head1 DESCRIPTION

HTTP::MobileAgent::Plugin::Charset is a plugin of HTTP::MobileAgent.

You can detect encoding. The result can use with Encode::JP::Mobile.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom aaaatttt gmail dotottto commmmmE<gt>

=head1 SEE ALSO

L<HTTP::MobileAgent>, L<Encode::JP::Mobile>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
