include <reg-common.scad>;
// pentagono
ANCHO = 150;
LADOS = 8;
ANILLOS = 3;
// para el hexagno, la relacion entre el lado de un cuadrado
// y el lado de un hexagno optimo segun http://mathafou.free.fr/pbg_en/sol118.html
COEFICIENTE_LADO = 0.4142;

function get_angulo(lados=LADOS) = (360 / lados);
function get_largo_lado(valor_base=ANCHO, coeficiente_lado=COEFICIENTE_LADO) = ( valor_base * coeficiente_lado ); 
function get_inradius(largo_lado) = (largo_lado / (2 * tan(get_angulo() / 2)));

regla(ancho=ANCHO, lados=LADOS, anillos=ANILLOS);

/* translate([0, 0, -1]) */
/*   color("Aqua") */ 
/*     cube([150, 150, 3], center=true); */
  
