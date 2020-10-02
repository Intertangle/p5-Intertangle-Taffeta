use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Color::RGBFloat;
# ABSTRACT: A floating point RGB colour

use Mu;
use Intertangle::Taffeta::Types qw(RGBFloatComponentValue);

extends qw(Intertangle::Taffeta::Color);

=attr r_float

Red component as C<RGBFloatComponentValue>.

=cut
has r_float => ( is => 'ro', isa => RGBFloatComponentValue );

=attr g_float

Green component as C<RGBFloatComponentValue>.

=cut
has g_float => ( is => 'ro', isa => RGBFloatComponentValue );

=attr b_float

Blue component as C<RGBFloatComponentValue>.

=cut
has b_float => ( is => 'ro', isa => RGBFloatComponentValue );

=method rgb_float_triple

Returns a list of the float components C<(r_float, g_float, b_float)>.

=cut
method rgb_float_triple() {
	($self->r_float, $self->g_float, $self->b_float);
}

=method svg_value

A C<Str> representing the floating point RGB triple as a percentage RGB

  rgb(25%,50%,75%)

is the SVG value for

  Intertangle::Taffeta::Color::RGBFloat->new(
    r_float => 0.25,
    g_float => 0.50,
    b_float => 0.75,
  );

=cut
method svg_value() {
	sprintf("rgb(%f%%, %f%%, %f%%)",
		$self->r_float * 100,
		$self->g_float * 100,
		$self->b_float * 100,
	);
}

1;
