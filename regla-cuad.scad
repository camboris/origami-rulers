include <reg-common.scad>;
// pentagono
ANCHO = 150;
LADOS = 4;
ANILLOS = 3;
COEFICIENTE_LADO = 1;

/* funciones especificas para esta figura */

function get_angulo(lados=LADOS) = (360 / lados);
function get_largo_lado(valor_base, coeficiente_lado=COEFICIENTE_LADO) = ( valor_base * coeficiente_lado ); 
function get_inradius(largo_lado) = (largo_lado / 2);

regla(ancho=ANCHO, lados=LADOS, anillos=ANILLOS);
