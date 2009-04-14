use Test::More tests => 6;

BEGIN { use_ok WWW::Shorten::Digg };

my $url = 'http://www.broerse.net/wordpress/';
my $code = 'u1cGK';
my $prefix = 'http://digg.com/';
is ( makeashorterlink($url), $prefix.$code, 'make it shorter');
is ( makealongerlink($prefix.$code), $url, 'make it longer');
is ( makealongerlink($code), $url, 'make it longer by Id',);

eval { &makeashorterlink() };
ok($@);
eval { &makealongerlink() };
ok($@);
