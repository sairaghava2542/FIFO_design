# Async FIFO SDC Constraints for ICC2 - 32nm Technology
# ====================================================

# ----------------------------------------------
# Clock Definitions
# ----------------------------------------------
create_clock -name wr_clk -period 10 [get_ports wr_clk] ;# 100 MHz
create_clock -name rd_clk -period 14 [get_ports rd_clk] ;# ~71.4 MHz

# ----------------------------------------------
# Input Delay (Assuming external launch on same clock domain)
# ----------------------------------------------
set_input_delay -max 1 -clock wr_clk [get_ports wr_data]
set_input_delay -max 1 -clock wr_clk [get_ports wr_en]
set_input_delay -max 1 -clock rd_clk [get_ports rd_en]
set_input_delay -max 1 -clock wr_clk [get_ports rst]

# ----------------------------------------------
# Input Transition Times
# ----------------------------------------------
set_input_transition 0.17 [get_ports wr_data]
set_input_transition 0.17 [get_ports wr_en]
set_input_transition 0.17 [get_ports rd_en]
set_input_transition 0.17 [get_ports rst]

# ----------------------------------------------
# Output Delay (Assuming external capture)
# ----------------------------------------------
set_output_delay -max 1 -clock wr_clk [get_ports full]
set_output_delay -max 1 -clock rd_clk [get_ports empty]
set_output_delay -max 1 -clock rd_clk [get_ports rd_data]

# ----------------------------------------------
# Clock Uncertainty
# ----------------------------------------------
set_clock_uncertainty -setup 0.07 [get_clocks wr_clk]
set_clock_uncertainty -setup 0.07 [get_clocks rd_clk]
set_clock_uncertainty -hold 0.2 [get_clocks wr_clk]
set_clock_uncertainty -hold 0.2 [get_clocks rd_clk]

# ----------------------------------------------
# Max Transition for All Paths
# ----------------------------------------------
set_max_transition 0.2 [current_design]

# ----------------------------------------------
# Max Transition for Clock Paths
# ----------------------------------------------
set_max_transition -clock_path 0.05 [get_clocks wr_clk]
set_max_transition -clock_path 0.05 [get_clocks rd_clk]

# ----------------------------------------------
# False Path for Asynchronous Reset
# ----------------------------------------------
set_false_path -from [get_ports rst]

# ----------------------------------------------
