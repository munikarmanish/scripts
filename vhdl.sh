#!/bin/bash

echo "Compiling unit" && \
    ghdl -a ${1}.vhdl && \
    echo "Compiling testbench" && \
    ghdl -a ${1}_tb.vhdl && \
    echo "Building testbench executable" && \
    ghdl -e ${1}_tb && \
    echo "Running testbench simulation" && \
    ./${1}_tb --vcd=w && \
    echo "Output file generated!"
