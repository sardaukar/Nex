# NEX

Elixir/OpenGL NES Emulator, because why the heck not.
All technology is pointless.


## Short-term TODO list

* Turn CPU into a Genserver
* Initialize CPU registers


## Notes


http://nesdev.com/6502.txt
NesTest is a NROM-128 with no mapper
In NROM-128, the 16k PRG ROM is mirrored into both $8000-$BFFF and $C000-$FFFF.
So execution can start at C000, which is really location 0000 in the ROM itself. 
What have I gotten myself into. Mappers are going to require some thought...



```
t = Nex.CPU.boot("test/roms/nestest/nestest.nes")
{t2, _} = Nex.CPU.run_instruction(t)  # JPM
{t3, _} = Nex.CPU.run_instruction(t2) # LDX
{t4, _} = Nex.CPU.run_instruction(t3) # STX
{t5, _} = Nex.CPU.run_instruction(t4) # STX
{t6, _} = Nex.CPU.run_instruction(t5) # STX
{t7, _} = Nex.CPU.run_instruction(t6) # JSR

```

