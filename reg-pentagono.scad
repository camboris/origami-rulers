include <reg-common.scad>;
// pentagono
ANCHO = 150;
LADOS = 5;
ANILLOS = 3;
// para el pentagono, la relacion entre el lado de un cuadrado
// y el lado de un pentagono optimo segun http://mathafou.free.fr/pbg_en/sol118.html
COEFICIENTE_LADO = 0.62573786;

/* funciones especificas para esta figura */

function get_angulo(lados=LADOS) = (360 / lados);
function get_largo_lado(valor_base, coeficiente_lado=COEFICIENTE_LADO) = ( valor_base * coeficiente_lado ); 
function get_inradius(largo_lado) = ((largo_lado / 2) * abs((1 / tan(get_angulo() * 2))));

regla(ancho=ANCHO, lados=LADOS, anillos=ANILLOS);
