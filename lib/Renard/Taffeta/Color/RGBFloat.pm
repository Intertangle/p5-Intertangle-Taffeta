use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Color::RGBFloat;
# ABSTRACT: A floating point RGB colour

use Mu;
use Renard::Taffeta::Types qw(RGBFloatComponentValue);

extends qw(Renard::Taffeta::Color);

has r_float => ( is => 'ro', isa => RGBFloatComponentValue );
has g_float => ( is => 'ro', isa => RGBFloatComponentValue );
has b_float => ( is => 'ro', isa => RGBFloatComponentValue );

method rgb_float_triple() {
	($self->r_float, $self->g_float, $self->b_float);
}

method svg_value() {
	sprintf("rgb(%f%%, %f%%, %f%%)"
		$self->r_float * 100,
		$self->g_float * 100,
		$self->b_float * 100,
	);
}

1;
