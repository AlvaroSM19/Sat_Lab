# Project Overview

- All used files have been commented to enhance readability.
- Sampling frequency is set to 100 000 samples/second.

## Files Used

- **visible_satellite.csv**: May require updating with correct information.
- **scenario_manager.ini**: May require updating with correct information.


## Modulation Scheme

An image of the modulation scheme is included

The packet format used is as follows:

- 8 bits for SAT_ID
- 12 bits for week
- 20 bits for tow
- 32 bits for each eci_pos component
- 32 bits for each eci_v component
- 32 bits for each ecef_pos component
- 32 bits for each ecef_v component
- Random bits to reach 1000 bits per packet

## Execution

Executing the main file (`top_file.m`) should be sufficient to generate all necessary files.
