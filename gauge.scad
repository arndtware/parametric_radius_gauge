$fn = 128;

module gauge(gauge_size, gauge_width, gauge_height, gauge_thickness, hole_size) {
    body_radius = 5;

    difference() {
        union() {
            difference(){
                union() {
                    minkowski()
                    {
                      cube([gauge_width - body_radius, gauge_height - body_radius, gauge_thickness / 2], center = true);
                      cylinder(d = body_radius, h = gauge_thickness / 2, center = true);
                    }

                    translate([-((gauge_width / 2) - (body_radius / 2)), (gauge_height / 2)  - (body_radius / 2), 0])
                        cube([body_radius, body_radius, gauge_thickness], center = true);

                    translate([(gauge_width / 2) - (body_radius / 2), (gauge_height / 2)  - (body_radius / 2), 0])
                        cube([body_radius, body_radius, gauge_thickness], center = true);
                }

                translate([-(gauge_width / 2), gauge_height / 2, 0])
                    cylinder(h = gauge_thickness, r1 = gauge_size, r2 = gauge_size, center = true);

                translate([gauge_width / 2, gauge_height / 2, 0])
                    cylinder(h = gauge_thickness, r1 = gauge_size, r2 = gauge_size, center = true);
            };

            translate([(gauge_width / 2) - gauge_size, gauge_height / 2 - gauge_size, 0])
                difference() {
                    cylinder(h = gauge_thickness, r1 = gauge_size, r2 = gauge_size, center = true);

                    translate([-gauge_size/2, -gauge_size/2, 0])
                        cube([gauge_size, gauge_size, gauge_thickness], center = true);

                    translate([-gauge_size/2, gauge_size/2, 0])
                        cube([gauge_size, gauge_size, gauge_thickness], center = true);

                    translate([gauge_size/2, -gauge_size/2, 0])
                        cube([gauge_size, gauge_size, gauge_thickness], center = true);
                };
        };

        if (hole_size > 0) {
            translate([(gauge_width / 2) - 3.5, -((gauge_height / 2) - 3.5), 0])
                cylinder(h = gauge_thickness, d = hole_size, center = true);
        }

        translate([0, -(gauge_height / 3), 0])
            linear_extrude(gauge_thickness, center = true)
                text(str(gauge_size, "mm"), size = 6, valign = "center", halign = "center", font = "OpenSans:style=Extrabold");
    };
}



thickness = false;
hole = 5.5;
size = 30;
g_width = 65;
g_height = 35;
g_thickness = 1.5;

if(thickness) {
    gauge(size, g_width, g_height, size, hole);
}
else {
    gauge(size, g_width, g_height, g_thickness, hole);
}
