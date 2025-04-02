import xarray as xr
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon

# Open the NetCDF file
file_path = "/Users/hkershaw/DART/Tickets/Nuo/ice/dart_grid.nc"  # Replace with your file path
dataset = xr.open_dataset(file_path)

# Access the variables
tlon = dataset["TLON"].values  # Convert to NumPy array
tlat = dataset["TLAT"].values  # Convert to NumPy array

# Get the shape of the grid
nrows, ncols = tlon.shape

# List to store quads
quads = []

# Iterate over the grid to extract 4-point quads
for i in range(nrows - 1):  # Loop over rows
    for j in range(ncols - 1):  # Loop over columns
        # Extract the 4 corner points of the quad
        quad = {
            "lon": [tlon[i, j], tlon[i, j + 1], tlon[i + 1, j + 1], tlon[i + 1, j]],
            "lat": [tlat[i, j], tlat[i, j + 1], tlat[i + 1, j + 1], tlat[i + 1, j]],
        }
        quads.append(quad)

# Close the dataset (optional)
dataset.close()

# Create a single figure with subplots
fig, (ax_main, ax_corners) = plt.subplots(1, 2, figsize=(16, 8))
plt.subplots_adjust(wspace=0.4)  # Add space between subplots

# Plot the grid points in the main plot
ax_main.scatter(tlon, tlat, s=1, color='blue', label='Grid Points')  # Scatter plot for grid points
ax_main.set_xlabel("Longitude")
ax_main.set_ylabel("Latitude")
ax_main.set_title("Grid with Quad Highlighted")
ax_main.legend()
ax_main.grid(True)

# Iterate over the quads and plot one at a time
for idx, quad in enumerate(quads[-100:]):  # Plot the last 1000 quads as an example
    ax_main.cla()  # Clear the main plot
    ax_corners.cla()  # Clear the corners plot

    # Plot the grid points in the main plot
    ax_main.scatter(tlon, tlat, s=1, color='blue', label='Grid Points')

    # Create and plot the polygon for the current quad in the main plot
    polygon = Polygon(xy=list(zip(quad["lon"], quad["lat"])), closed=True, edgecolor='red', fill=False, linewidth=1.5)
    ax_main.add_patch(polygon)

    # Highlight the quad corners in the subplot
    ax_corners.scatter(quad["lon"], quad["lat"], color='red', label='Quad Corners')
    ax_corners.plot(quad["lon"] + [quad["lon"][0]], quad["lat"] + [quad["lat"][0]], color='red')  # Connect corners
    ax_corners.set_xlabel("Longitude")
    ax_corners.set_ylabel("Latitude")
    ax_corners.set_title(f"Quad {idx + 1} Corners")
    ax_corners.legend()
    ax_corners.grid(True)

    # Set equal aspect ratio for the corners subplot
    ax_corners.set_aspect('equal', adjustable='datalim')

    # Update the main plot title
    ax_main.set_title(f"Quad {idx + 1}")

    # Pause to display the current quad
    plt.pause(0.1)  # Pause for 0.1 seconds to visualize each quad