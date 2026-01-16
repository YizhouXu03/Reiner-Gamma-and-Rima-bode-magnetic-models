import numpy as np
import matplotlib.pyplot as plt
import pyshtools as pysh
import matplotlib.pyplot as plt
from cartopy import crs as ccrs
from pyshtools import constants
import math
plt.rcParams.update({
    'font.size': 14,
    'axes.labelsize': 16,
    'xtick.labelsize': 20,
    'ytick.labelsize': 16,
    'legend.fontsize': 14,
    'figure.titlesize': 18
})
pysh.utils.figstyle(rel_width=0.75)
clm = (pysh.datasets.Moon.LDEM_shape_pa()/1000)
clm.info()
clm.coeffs[0,0,0] = 0.
clm.coeffs[0,2,0] = 0.
grid = clm.expand()
fig, ax = grid.plot(
    cmap='jet',
    projection=ccrs.PlateCarree(central_longitude=360.),
    tick_interval=[30, 30],
    colorbar='right',
    cb_label='km',
    cb_triangles='both',
    grid=False,
    show=False
)
cbar = fig.axes[1]
cbar.tick_params(labelsize=16)
cbar.set_ylabel('km', fontsize=16)
ax.set_xlabel('longitude', fontsize=16)
ax.set_ylabel('latitude', fontsize=16)
ax.set_xticks([-180, -150, -120, -90, -60, -30, 0, 30, 60, 90, 120, 150, 180], crs=ccrs.PlateCarree())
ax.set_xticklabels(['180°E', '150°W', '120°W', '90°W', '60°W', '30°W', '0°', '30°E', '60°E', '90°E', '120°E', '150°E', '180°W'])
ax.set_title('(a)', loc='left', fontsize=16)
reiner_gamma_lon = [295, 310, 310, 295, 295]
reiner_gamma_lat = [0, 0, 15, 15, 0]
ax.plot(reiner_gamma_lon, reiner_gamma_lat, 'k-', transform=ccrs.Geodetic())
ax.text(302.5, 16, 'Reiner Gamma', color='black',
        horizontalalignment='center', transform=ccrs.Geodetic(),
        fontsize=10, fontweight='bold')
rima_bode_lon_west = [360, 350, 350, 360]
rima_bode_lat_west = [5, 5, 20, 20]
ax.plot(rima_bode_lon_west, rima_bode_lat_west, 'k-', transform=ccrs.Geodetic())
rima_bode_lon_east = [0, 5, 5, 0]
rima_bode_lat_east = [5, 5, 20, 20]
ax.plot(rima_bode_lon_east, rima_bode_lat_east, 'k-', transform=ccrs.Geodetic())
ax.plot([360, 0], [5, 5], 'r-', transform=ccrs.Geodetic())
ax.text(357.5, 21, 'Rima Bode', color='black',
        horizontalalignment='center', transform=ccrs.Geodetic(),
        fontsize=10, fontweight='bold')
ax.plot(302.5, 7.5, 'r*', markersize=8, transform=ccrs.Geodetic())
ax.plot(357.5, 12.5, 'r*', markersize=8, transform=ccrs.Geodetic())
plt.show()