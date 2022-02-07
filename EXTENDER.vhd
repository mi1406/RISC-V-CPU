-- sign extender
-- Author: Mario Ivanov

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity sign_ext is
    generic(INST_XLEN : integer := 32; XLEN : integer := 64);
    port (
        instruction : in STD_LOGIC_VECTOR(INST_XLEN-1 downto 7);
        immediateSrc : in STD_LOGIC_VECTOR(1 downto 0);
        immediateExt : out STD_LOGIC_VECTOR(XLEN-1 downto 0)
    );
end entity;