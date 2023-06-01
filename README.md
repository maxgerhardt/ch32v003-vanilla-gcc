# ch32v003-vanilla-gcc
Firmware for CH32V003 that's compilable with standard, open-source RISC-V GCC.

Use https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/tag/v12.2.0-3/

Adapt path in `build.bat`.

Critical chagnes to make the startup file and Core RISC-V source compile is to add 

```cpp
#if __GNUC__ > 10
".option arch, +zicsr\n"
#endif
```
in C code using `asm` instructions (for ones doing CSRW instructions and related), and similiarly doing

```as
#if __GNUC__ > 10
.option arch, +zicsr
#endif
```
in the startup file.
