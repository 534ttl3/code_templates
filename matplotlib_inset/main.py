import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid.inset_locator import inset_axes, zoomed_inset_axes

fig, ax1 = plt.subplots()
axins = inset_axes(ax1, 1, 1, loc=2, bbox_to_anchor=(0.2, 0.55), bbox_transform=ax1.figure.transFigure) 
axins_zoomed = zoomed_inset_axes(ax1, 3.5, loc=2, bbox_to_anchor=(0.2, 0.55), bbox_transform=ax1.figure.transFigure) 

data_gelf = range(10)

ax1.plot(data_gelf, color='red')

axins.set_xlim(3, 4)
axins.set_ylim(3, 4)
axins.plot(data_gelf, color='red')

axins_zoomed.set_xlim(3, 4)
axins_zoomed.set_ylim(3, 4)
axins_zoomed.plot(data_gelf, color='red')

plt.show()
