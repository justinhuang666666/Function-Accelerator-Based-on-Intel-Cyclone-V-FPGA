# Function Accelerator Based on Intel Cyclone V FPGA
This project is a semaster long project for Digital System Design. 
# Directory Structure
* first_nios2_system11 - contain the final on board version of the design
* doc - contains all the report written to present performance analysis of various configuration and tradeoffs between FPGA resources, latency and application size
* ip - contains the verilog source code of customized hardwares such as CORDIC, Processing Element (PE) etc
* software - contains the source code of application to test the system performance

The system design will target a Field-Programmable Gate Array (FPGA) from Intel called Cyclone V DE1-SoC. The target CPU is the soft-processor NIOS II, also provided by Intel. More information about NIOS II can be found here: https://www.intel.co.uk/content/www/uk/en/products/programmable/processor/nios-ii.html

<img width="714" alt="Screenshot 2023-09-07 at 00 13 27" src="https://github.com/justinhuang666666/Function-Accelerator-Based-on-Intel-Cyclone-V-FPGA/assets/106251510/f15cf58f-97ae-41a7-ae95-a3b2a0535048">

# Design Highlight
We utilized the Extended Variable Cycle Custom Instruction. The instruction takes in two floating-point operands. Each time the custom instruction is called, two x array elements are pushed into the pipeline. The Extended N field of the custom instruction is used to signal the controller that the last element(s) has entered the pipeline (N = 8’b1 indicating the last element). Ideally, to exploit the full capacity of the pipeline, new operands should enter the pipeline every clock cycle. To achieve this, the custom instruction should be called every clock cycle. However, this is not achievable in the given NiosII custom instruction interface. The combinational custom instruction does not have a clock port which makes it impossible to clock the pipeline. Therefore, we use the variable length custom instruction with the start and done signal. During full pipeline computation, the done signal is asserted every two clock cycles so the current instruction is terminated and the upcoming instruction can bring new operands to the pipeline. Variable length is used because computations in the pipeline have different latencies. The last element in the function needs to propagate through the whole pipeline before the valid result is generated. From the perspective of the custom instruction interface, the length of the instruction during full pipeline computation is two clock cycles. And the length of the instruction is prolonged when calculating the last element.
