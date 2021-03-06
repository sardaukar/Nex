defmodule Nex.Opcodes.O41 do
  @moduledoc """
  AND                  "AND" memory with accumulator                    AND

  Operation:  A /\ M -> A                               N Z C I D V
                                                        / / _ _ _ _
                               (Ref: 2.2.3.0)
  +----------------+-----------------------+---------+---------+----------+
  | Addressing Mode| Assembly Language Form| OP CODE |No. Bytes|No. Cycles|
  +----------------+-----------------------+---------+---------+----------+
  |  Immediate     |   AND #Oper           |    29   |    2    |    2     |
  +----------------+-----------------------+---------+---------+----------+
  * Add 1 if page boundary is crossed.
  """

  @cycles 3
  def run(cpu) do
    use Bitwise
    alias Nex.CPU.StatusRegister
    {cpu, [value]} = Nex.CPU.read_from_pc(cpu, 1)
    nv = (value &&& cpu.registers.a)
    new_registers = cpu.registers.status
      |> StatusRegister.set_negative(nv)
      |> StatusRegister.set_zero(nv)
    cpu = Nex.CPU.update_status_reg(cpu, new_registers)
    op_log = %{bytes: [value], log: format(value)}
    {Nex.CPU.update_reg(cpu, :a, nv), @cycles, op_log}
  end
  def format(ops) do
    "AND #$#{String.upcase(Hexate.encode(ops, 2))}"
  end
end