defmodule Nex.Opcodes.O192 do
  @moduledoc """
  CPY                  CPY Compare memory and index Y                   CPY
                                                        N Z C I D V
  Operation:  Y - M                                     / / / _ _ _
                                 (Ref: 7.9)
  +----------------+-----------------------+---------+---------+----------+
  | Addressing Mode| Assembly Language Form| OP CODE |No. Bytes|No. Cycles|
  +----------------+-----------------------+---------+---------+----------+
  |  Immediate     |   CPY *Oper           |    C0   |    2    |    2     |
  +----------------+-----------------------+---------+---------+----------+
  """

  @cycles 2
  def run(cpu) do
    alias Nex.CPU.StatusRegister
    {cpu, [value]} = Nex.CPU.read_from_pc(cpu, 1)
    result = cpu.registers.y - value

    new_registers = cpu.registers.status
      |> StatusRegister.set_negative(result)
      |> StatusRegister.set_zero(result)
      |> StatusRegister.set_carry(result >= 0)
    cpu = Nex.CPU.update_status_reg(cpu, new_registers)

    op_log = %{bytes: [value], log: format(value)}
    {cpu, @cycles, op_log}
  end

  def format(ops) do
    "CPY #$#{String.upcase(Hexate.encode(ops, 2))}"
  end
end