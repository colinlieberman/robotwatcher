rrdtool create robotwatcher.rrd \
  --step 60 \
  DS:total:GAUGE:600:0:100 \
  DS:Kepler:GAUGE:600:0:20 \
  DS:Copernicus:GAUGE:600:0:20 \
  DS:Hubble:GAUGE:600:0:20 \
  DS:Brahe:GAUGE:600:0:20 \
  DS:Sagan:GAUGE:600:0:20 \
  DS:workers:GAUGE:600:0:5 \
  RRA:MAX:0.5:1:604800 \
  RRA:AVERAGE:0.5:3600:168
