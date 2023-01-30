# Clear the environment
clear -all
# Analyze design files
analyze -sv ./source/design/regfile.sv
# Analyze SVA file

# Elaborate design and properties

# Set up Clock and Reset

#Prove all properties
prove -all
