defmodule Nex.CartridgeTest do
  use ExUnit.Case

  test "loading fails if the file doesn't exit" do
    assert {:error, _} = Nex.Cartridge.load("")
  end

  test "parsing returns an error if it's not a valid INES file" do
    assert {:error, :invalid_nes_file} = Nex.Cartridge.load(__DIR__ <> "/roms/nestest/nestest.log")
  end

  test "parsing returns a INES struct if it's valid" do
    %Nex.Cartridge{} = Nex.Cartridge.load(__DIR__ <> "/roms/nestest/nestest.nes")
  end
end
