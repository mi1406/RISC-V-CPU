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

architecture BEHAVIOUR of sign_ext is
    
begin
sign_extend : process(instruction, immediateSrc)
begin
    case immediateSrc is
        -- I-type instruction
        when "00" => 
            immediateExt <= (XLEN - 1 downto 12 => instruction(INST_XLEN - 1)) & instruction(INST_XLEN - 1 downto INST_XLEN - 12);
        -- S-type instruction
        when "01" => 
            immediateExt <= (XLEN - 1 downto 12 => instruction(INST_XLEN - 1)) & instruction(INST_XLEN - 1 downto INST_XLEN - 7) & instruction(11 downto 7);
        -- B-type instruction
        when "10" => 
            immediateExt <= (XLEN - 1 downto 12 => instruction(INST_XLEN - 1) & instruction(7) & instruction(INST_XLEN - 2 downto INST_XLEN - 7) & instruction(11 downto 8)) & '0';
        -- J-type instruction
        when "11" => 
            immediateExt <= (XLEN - 1 downto 20 => instruction(INST_XLEN - 1) & instruction(19 downto 12) & instruction(20) & instruction(30 downto 21)) & '0';
        when others => 
            immediateExt <= (XLEN - 1 downto 0 => '0');
    end case;
end process;
end architecture;