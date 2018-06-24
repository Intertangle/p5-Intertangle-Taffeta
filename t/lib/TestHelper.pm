use Renard::Incunabula::Common::Setup;
package TestHelper;
# ABSTRACT: A helper for the tests

use List::AllUtils qw(count_by);

classmethod svg( :$render, :$width, :$height ) {
	require SVG;
	SVG->import;

	my $svg = SVG->new( width => $width, height => $height );

	$render->render_svg( $svg );

	return $svg;
}

classmethod cairo( :$render, :$width, :$height ) {
	require Cairo;
	my $surface = Cairo::ImageSurface->create('argb32', $width, $height);

	my $cr = Cairo::Context->create( $surface );

	$render->render_cairo( $cr );

	my @data = unpack 'L*', $surface->get_data; # uint32_t
	my %counts = count_by { $_ } @data;

	return {
		surface => $surface,
		counts => \%counts
	};
}


1;
