# FirstWS-and-EndWS
The codes and data to calculate FirstWS and EndWS
A small simulated water availability per capita dataset to demo the code calculating the first emergence of water scarcity (FirstWS) and the first disappearance time of water scarcity (EndWS).

Here, we address this knowledge gap by conducting a novel global-scale temporal analysis of the first emergence of water scarcity (FirstWS), defined as the first year when per-capita water availability at the grid scale is below a threshold of 1000 m3/person/year for at least five consecutive years between 1901 to 2090, and the first disappearance time of water scarcity (EndWS), defined as the first year of water scarcity relieved and whose scarcity-free situation (i.e., above the threshold) lasts until the end of the 21st century (2090). 

The Repositories includes five files:

(1)READMEs: A description file of instructions for reproducing the key results (identify FirstWs and EndWS);

(2)test_pixel_data.mat: A Matlab formated demo data (only one pixel to save time), which must be placed in current working directory;

(3)Cal_WS.m: The Core function to calculate FirstWs and EndWS, which must be placed in current working directory;

(4)test_FirstWS&EndWS.m: The demo code calculating the FirstWs and EndWS by calling function "Cal_WS.m", at the same time draw the picuture;

(5)test_FirstWS&EndWS.jpg: The Expected output.

The use of these codes: 
    The package has been tested on the Windows systems with MATLAB software.The package has been tested on the following systems:
        MATLAB Version: 9.10.0.1602886 (R2021a) 
        Operating System: Microsoft Windows 10 Professional Version 10.0 (Build 19044) 

Firstly unzip these files in your computer, then modify the working directory as your Unzip folder and Run. You are expected to obtain test_FirstWS&EndWS.jpg.
