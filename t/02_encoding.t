use strict;
use warnings;
use Test::Base;
use HTTP::MobileAgent;
use HTTP::MobileAgent::Plugin::Charset;

plan tests => 1*blocks;

filters {
    input => [qw/encoding/],
};

run_is input => 'expected';

sub encoding {
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
    $agent->encoding;
}

__END__

===
--- input: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.8) Gecko/20071019 Firefox/2.0.0.8
--- expected: utf-8

=== docomo foma
--- input: DoCoMo/2.0 N905iBiz(c100;TJ)
--- expected: x-utf8-docomo

=== docomo mova
--- input: DoCoMo/1.0/D501i
--- expected: x-sjis-docomo

=== 
--- input: Vodafone/1.0/V802SE/SEJ001/SNXXXXXXXXX Browser/SEMC-Browser/4.1 Profile/MIDP-2.0 Configuration/CLDC-1.10
--- expected: x-utf8-vodafone

===
--- input: J-PHONE/2.0/J-DN02
--- expected: x-sjis-vodafone

=== willcom
--- input: Mozilla/3.0(DDIPOCKET;JRC/AH-J3001V,AH-J3002V/1.0/0100/c50)CNF/2.0
--- expected: x-sjis-airh

=== willcom
--- input: Mozilla/3.0(DDIPOCKET;KYOCERA/AH-K3001V/1.4.1.67.000000/0.1/C100) Opera 7.0
--- expected: x-utf8-airh

=== ez
--- input: UP.Browser/3.01-HI01 UP.Link/3.4.5.2
--- expected: x-sjis-ezweb

=== ez
--- input: KDDI-TS21 UP.Browser/6.0.2.276 (GUI) MMP/1.1
--- expected: x-utf8-ezweb

