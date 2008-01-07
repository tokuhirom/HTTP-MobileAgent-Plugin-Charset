use inc::Module::Install;
name 'HTTP-MobileAgent-Plugin-Charset';
all_from 'lib/HTTP/MobileAgent/Plugin/Charset.pm';

requires $_ for (qw/ /);

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
