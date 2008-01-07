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
    local $ENV{HTTP_ACCEPT_CHARSET};
    if ($ua =~ /DDIPOCKET/) {
        $ENV{HTTP_ACCEPT_CHARSET} =
          ( $ua =~ /K3001V/ )
          ? 'shift_jis, utf-8, utf-16, iso-8859-1;q=0.6, *;q=0.1'
          : 'shift_jis; q=0.6, *;q=0.1';
    }
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

=== 
--- input: Vodafone/1.0/V802SE/SEJ001/SNXXXXXXXXX Browser/SEMC-Browser/4.1 Profile/MIDP-2.0 Configuration/CLDC-1.10
--- expected: utf8

===
--- input: J-PHONE/2.0/J-DN02
--- expected: no utf8

=== willcom
--- input: Mozilla/3.0(DDIPOCKET;JRC/AH-J3001V,AH-J3002V/1.0/0100/c50)CNF/2.0
--- expected: no utf8

=== willcom
--- input: Mozilla/3.0(DDIPOCKET;KYOCERA/AH-K3001V/1.4.1.67.000000/0.1/C100) Opera 7.0
--- expected: utf8

=== ez
--- input: UP.Browser/3.01-HI01 UP.Link/3.4.5.2
--- expected: no utf8

=== ez
--- input: KDDI-TS21 UP.Browser/6.0.2.276 (GUI) MMP/1.1
--- expected: utf8

