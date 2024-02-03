#!/bin/bash

echo "Choose architecture:"
echo "(1) Arrch64/ARM64"
echo "(2) x86_64/AMD64"

read -p "Enter your choice (1/2): " choice

if [ "$choice" -eq 1 ]; then
    make ARCH=arm64 defconfig
elif [ "$choice" -eq 2 ]; then
    make ARCH=x86_64 defconfig
else
    echo "Stopping execution"
    exit 1
fi

echo "Checking for the existence of .config file..."
if [ -e .config ]; then
    read -p "Configuration has been generated, do you want to start the compilation? (y/n, default is y): " compile_choice
    compile_choice=${compile_choice:-y}

    if [ "$compile_choice" == "n" ]; then
        echo "Stopping compilation"
        exit 1
    elif [ "$compile_choice" == "y" ]; then
        read -p "Enter the number of compilation processes (default is 1): " num_processes
        num_processes=${num_processes:-1}

        echo "Starting compilation..."
        make -j "$num_processes"

        echo -e "\e[32mCompilation has been completed\e[0m"
    else
        echo "Invalid input"
        exit 1
    fi
else
    echo ".config file does not exist"
    exit 1
fi
