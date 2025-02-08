$fn = 128;

module tray(gauge_width, gauge_height, guage_thickness, gauge_range, t_radius, wall_thickness) {
    gauge_slots_length = ((gauge_range[1] - 1) * wall_thickness) + (gauge_range[1] * guage_thickness);
    gauge_slots_height = gauge_height * 0.25;

    tray_length = gauge_slots_length + (wall_thickness * 2);
    tray_width = gauge_width + (wall_thickness * 2);
    tray_height = gauge_slots_height;

    lip_length = tray_length + (wall_thickness * 2);
    lip_width = tray_width + (wall_thickness * 2);

    union() {
        difference() {
            cube([gauge_width, gauge_slots_length, gauge_slots_height], center = true);

            for(count = [gauge_range[0] : gauge_range[1]]) {
                start_y = -(gauge_slots_length / 2);
                wall_offset = (count - 1) * wall_thickness;
                gauge_offset = (count - 1) * guage_thickness;
                y_pos = start_y + gauge_offset + wall_offset;
                translate([-(gauge_width / 2), y_pos, -(gauge_height / 2)])
                    cube([gauge_width, guage_thickness, gauge_height]);
            };
        };

        difference() {
            cube([tray_width, tray_length, tray_height], center = true);

            cube([gauge_width, gauge_slots_length, gauge_slots_height], center = true);
        };

        translate([0, 0, -(wall_thickness / 2)])
            linear_extrude(tray_height - wall_thickness, center = true)
                difference() {
                    offset(r = t_radius) {
                        square([(lip_width - (t_radius * 2)), (lip_length - (t_radius * 2))], center = true);
                    };

                    square([tray_width, tray_length], center = true);
                };

        translate([0, 0, -((tray_height / 2) + (wall_thickness / 2))])
            difference() {
                minkowski() {
                    cube([tray_width, tray_length, wall_thickness], center = true);
                    cylinder(h = wall_thickness, r1 = 0, r2 = t_radius);
                };

                translate([0, 0, wall_thickness])
                    cube([lip_width, lip_length, wall_thickness], center = true);
            };
    };
};

module lid(gauge_width, gauge_height, guage_thickness, gauge_range, t_radius, wall_thickness, p_tolerance) {
    outer_length = ((gauge_range[1] - 1) * wall_thickness) + (gauge_range[1] * guage_thickness) + (wall_thickness * 4);
    outer_width = gauge_width + (wall_thickness * 4);

    inner_height = (gauge_height * 0.75) + wall_thickness;
    inner_width = outer_width - (wall_thickness * 2);
    inner_length = outer_length - (wall_thickness * 2);

    union() {
        linear_extrude(inner_height, center = true)
            difference() {
                offset(r = t_radius) {
                    square([(outer_width - (t_radius * 2)), (outer_length - (t_radius * 2))], center = true);
                };

                square([inner_width + p_tolerance, inner_length + p_tolerance], center = true);
            };

        translate([0, 0, -((inner_height / 2) + (wall_thickness / 2))])
            difference() {
                minkowski() {
                    cube([inner_width, inner_length, wall_thickness], center = true);
                    cylinder(h = wall_thickness, r1 = 0, r2 = t_radius);
                };

                translate([0, 0, wall_thickness])
                    cube([outer_width, outer_length, wall_thickness], center = true);
            };
    };
};

tolerance = 0.5;
radius = 2;
w_thickness = 2;
g_width = 65 + (tolerance);
g_height = 35 + (tolerance);
g_thickness = 1.5 + (tolerance);
g_range = [1, 30];

translate([40, 0, 0])
    tray(g_width, g_height, g_thickness, g_range, radius, w_thickness);
translate([-40, 0, 0])
    lid(g_width, g_height, g_thickness, g_range, radius, w_thickness, tolerance);
