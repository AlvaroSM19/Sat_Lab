#Executing the top file should be sufficient to generate of the files.
#I have commented all the used files in order to be easier to understand them.
#The visible_satellite.csv and scenario_manager may need to be updated with the correct info.
#I also included an image with the modulation scheme.
 #Packet format
    #8 bits for SAT_ID
    #12 bits for week
    #20 bits for tow
    #32 bits for each eci_pos component
    #32 bits for each eci_v component
    #32 bits for each ecef_pos component
    #32 bits for each ecef_v component
    #Random bits to reach 1000 bits per packet
