rem Change compiler path if needed here
rem set COMPILER_PATH=C:\MounRiver\MounRiver_Studio\toolchain\RISC-V Embedded GCC\bin
set COMPILER_PATH=C:\Users\Max\Downloads\xpack-riscv-none-elf-gcc-12.2.0-3-win32-x64\xpack-riscv-none-elf-gcc-12.2.0-3\bin

set SDK_FILES=ch32v00x_gpio.c ch32v00x_rcc.c ch32v00x_usart.c ch32v00x_misc.c
set RISC_CORE_FILE=core_riscv.c 
set DEBUG_FILE=debug.c
set SYSTEM_FILE=system_ch32v00x.c
set STARTUP_FILE=startup_ch32v00x.S

rem Build and Disassemble for RV32EC
"%COMPILER_PATH%\riscv-none-elf-gcc" -o firmware.elf -march=rv32ec -mabi=ilp32e -Os -msave-restore -nostartfiles -T Link_CH32V00x.ld -I. main_application.c %RISC_CORE_FILE% %SDK_FILES% %DEBUG_FILE% %SYSTEM_FILE% %STARTUP_FILE%

"%COMPILER_PATH%\riscv-none-elf-objcopy" -Obinary firmware.elf firmware.bin
"%COMPILER_PATH%\riscv-none-elf-objdump" -d firmware.elf > firmware.S

rem Flash using WCH's OpenOCD 
set OPENOCD_PATH=C:\MounRiver\MounRiver_Studio\toolchain\OpenOCD\bin
"%OPENOCD_PATH%\openocd.exe" -s "%OPENOCD_PATH%" -f wch-riscv.cfg -c "program firmware.elf verify; reset; shutdown;"
