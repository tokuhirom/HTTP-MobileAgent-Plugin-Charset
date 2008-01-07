use strict;
use warnings;
use Test::Base;
use HTTP::MobileAgent;
use HTTP::MobileAgent::Plugin::Charset;

plan tests => 1*blocks;

filters {
    input => [qw/can_display_utf8/],
};

run_is input => 'expected';

sub can_display_utf8 {
    my $ua = shift;

    local $ENV{HTTP_USER_AGENT} = $ua;
    my $agent = HTTP::MobileAgent->new;
    $agent->can_display_utf8 ? 'utf8' : 'no utf8';
}

__END__

===
--- input: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.8) Gecko/20071019 Firefox/2.0.0.8
--- expected: utf8

=== docomo foma
--- input: DoCoMo/2.0 N905iBiz(c100;TJ)
--- expected: utf8

=== docomo mova
--- input: DoCoMo/1.0/D501i
--- expected: no utf8

