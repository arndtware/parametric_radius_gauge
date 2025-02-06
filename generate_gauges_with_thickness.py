import subprocess


for number in range(1,31):
    cmd = f'openscad -o 3mf_gauges_with_thickness/{number}mm_radius_and_thickness.3mf -D size={number} -D thickness=true gauge.scad'
    subprocess.run(cmd, shell=True)

for number in range(1,31):
    cmd = f'openscad -o stl_gauges_with_thickness/{number}mm_radius_and_thickness.stl -D size={number} -D thickness=true gauge.scad'
    subprocess.run(cmd, shell=True)
