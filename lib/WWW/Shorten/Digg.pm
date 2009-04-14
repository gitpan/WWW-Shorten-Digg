# $Id$

=head1 NAME

WWW::Shorten::Digg - Perl interface to digg.com

=head1 SYNOPSIS

  use WWW::Shorten::Digg;
  use WWW::Shorten 'Digg';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site digg.com.  Digg maintains
a database of long URLs, each of which has a unique identifier.

=cut

package WWW::Shorten::Digg;

use 5.006;
use strict;
use warnings;
use URI::Escape;
use HTML::Entities;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
our $VERSION = '0.01';

use Carp;

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the Digg web site passing
it your long URL and will return the shorter Digg version.

=cut

sub makeashorterlink ($)
{
    my $url =  uri_escape(shift) or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $diggurl = "http://services.digg.com/url/short/create?url=$url&appkey=http%3A%2F%2Fsearch.cpan.org%2Fsearch%3Fquery%3DWWW-Shorten-Digg&type=xml";
    my $resp = $ua->get($diggurl);
    return undef unless $resp->is_success;
    my $content = $resp->content;
    if ($resp->content =~ m!short_url="(\Qhttp://digg.com/\E\w+)"!x) {
    	return $1;
    }
    return;
}

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Digg URL or just the
Digg identifier.

If anything goes wrong, then either function will return C<undef>.

=cut

sub makealongerlink ($)
{
    my $short =  uri_escape(shift) or croak 'No Digg key / URL passed to makealongerlink';
    if ($short =~ m!\Qhttp%3A%2F%2Fdigg.com%2F\E(\w+)!x) {
      $short = $1;
    }
    my $ua = __PACKAGE__->ua();
    my $diggurl = "http://services.digg.com/url/short/$short?appkey=http%3A%2F%2Fsearch.cpan.org%2Fsearch%3Fquery%3DWWW-Shorten-Digg&type=xml";
    my $resp = $ua->get($diggurl);
    return undef unless $resp->is_success;
    my $content = $resp->content;
    if ($resp->content =~ m!link="(.*?)"!x) {
      return decode_entities($1, '<&>"');
    }
    return;
}

1;

__END__

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Martin Broerse <broerse@martinic.com>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://apidoc.digg.com/ShortURLs>

=head1 COPYRIGHT

E<copy> Martinic 2009. This module is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.

For more information on Martinic visit L<http://www.martinic.com/>.

=cut
