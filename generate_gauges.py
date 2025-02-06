import subprocess

for number in range(1,31):
    cmd = f'openscad -o 3mf_gauges/{number}mm_radius.3mf -D size={number} gauge.scad'
    subprocess.run(cmd, shell=True)

for number in range(1,31):
    cmd = f'openscad -o stl_gauges/{number}mm_radius.stl -D size={number} gauge.scad'
    subprocess.run(cmd, shell=True)