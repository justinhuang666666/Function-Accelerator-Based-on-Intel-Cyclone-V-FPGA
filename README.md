# Function Accelerator Based on Intel Cyclone V FPGA
This project is a semaster long project for Digital System Design. 
# Directory Structure
* first_nios2_system11 - contain the final on board version of the NiosII processor
* doc - contains all the report written to present performance analysis of various configuration and tradeoffs between FPGA resources, latency and application size
* ip - contains the verilog source code of customized hardwares such as CORDIC, Processing Element (PE) etc
* software - contains the source code of application to test the system performance

# Project Description
The system design will target a Field-Programmable Gate Array (FPGA) from Intel called Cyclone V DE1-SoC. The target CPU is the soft-processor NIOS II, also provided by Intel. More information about NIOS II can be found here: https://www.intel.co.uk/content/www/uk/en/products/programmable/processor/nios-ii.html

<p align="center">
<img width="714" alt="Screenshot 2023-09-07 at 00 13 27" src="https://github.com/justinhuang666666/Function-Accelerator-Based-on-Intel-Cyclone-V-FPGA/assets/106251510/f15cf58f-97ae-41a7-ae95-a3b2a0535048">
</p>

# Design Highlight
We utilized the Extended Variable Cycle Custom Instruction. The instruction takes in two floating-point operands. Each time the custom instruction is called, two x array elements are pushed into the pipeline. The Extended N field of the custom instruction is used to signal the controller that the last element(s) has entered the pipeline (N = 8’b1 indicating the last element). Ideally, to exploit the full capacity of the pipeline, new operands should enter the pipeline every clock cycle. To achieve this, the custom instruction should be called every clock cycle. However, this is not achievable in the given NiosII custom instruction interface. The combinational custom instruction does not have a clock port which makes it impossible to clock the pipeline. Therefore, we use the variable length custom instruction with the start and done signal. During full pipeline computation, the done signal is asserted every two clock cycles so the current instruction is terminated and the upcoming instruction can bring new operands to the pipeline. Variable length is used because computations in the pipeline have different latencies. The last element in the function needs to propagate through the whole pipeline before the valid result is generated. From the perspective of the custom instruction interface, the length of the instruction during full pipeline computation is two clock cycles. And the length of the instruction is prolonged when calculating the last element.


As shown in figure 6, the module which is responsible for pipeline control is CUSTOM_INSTRUCTION. Its implementation is a finite state machine with three stages: IDLE, PROCESS, and FINISH. The IDLE state waits for the first clk_en and triggers the internal clock enable clk_en_use. The clk_en_use is asserted throughout the computation until the result is valid. This signal ensures that the pipeline remains operational even if the custom instruction is terminated (clk_en de-asserted). The PROCESS state is where full pipeline computation takes place. New dataa and datab is transferred to the Processing Element (PE) every two clock cycles when Start is asserted (ie. When new elements enter the pipeline via custom instruction). When the last element is not entered to the pipeline (N != 1), the state machine remains at PROCESS stage. During the verification stage of our design, we discovered that the ALFP_MULT IP output undetermined states between cycle 4 to cycle 7 after startup. These undetermined states propagate in the pipeline and corrupt the computation result. To resolve this issue, we introduce the counter COUNT_INIT. This asserts the signal tick (in module PE) during cycle 4 to cycle 7. The tick is used to mux between 32’b0 during cycle 4 to cycle 7 and valid multiplication result after startup. The FINISH state waits for the computation on the last element to complete. Counter COUNT is triggered at the beginning and keeps counting to CYCLE_DELAY. At this point, a valid result is stablised in the adder tree and a final done signal is asserted so the custom instruction interface can read the result from the hardware.
<p align="center">
<img width="379" alt="Screenshot 2023-09-07 at 00 42 33" src="https://github.com/justinhuang666666/Function-Accelerator-Based-on-Intel-Cyclone-V-FPGA/assets/106251510/7cd6297c-cb59-4f40-bf8a-6ac8aba4e77c">
</p>

The tree adder is mainly used to calculate the total sum. Since after the last value gets into the last recursive adder, we need to wait 8 cycles such that all the partial sums are calculated by this adder, and we need to add these 8 values together, so now this adder can be considered as a kind of FIFO, each cycle, one value would pomp out, and we need to store the first out values for the final sum. That’s why the output of this adder is sent to 7 sets of ‘shift registers’, these sets will be delayed by 7 cycles, 6 cycles, 5 cycles, 4 cycles, 3 cycles, 2 cycles, 1 cycle, respectively. Seven outputs of this shift structure together with the direct connection of output of that recursive adder will be sent to the tree structured adders, such kind of structure should be the fastest but requires more resources. So, for the pipelined version, the result would be valid by 76 cycles after the last valid input comes in.
<p align="center">
<img width="538" alt="Screenshot 2023-09-07 at 00 52 44" src="https://github.com/justinhuang666666/Function-Accelerator-Based-on-Intel-Cyclone-V-FPGA/assets/106251510/40c3eeda-c88f-482a-bab1-5f87d688acb0">
</p>


