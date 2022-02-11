-- Register file
-- Author: Mario Ivanov

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity reg_file is
generic(XLEN : integer := 64);
    port(
        clk            :in std_logic;
        sresetn        :in std_logic; 
        writeEanble    :in std_logic;
        reg1           :in std_logic_vector(5 - 1 downto 0);
        reg2           :in std_logic_vector(5 - 1 downto 0);
        reg3           :in std_logic_vector(5 - 1 downto 0);
        reg4           :in std_logic_vector(5 - 1 downto 0);
        reg5           :in std_logic_vector(5 - 1 downto 0);
        reg6           :in std_logic_vector(5 - 1 downto 0);
        writeReg1      :in std_logic_vector(5 - 1 downto 0);
        writeReg2      :in std_logic_vector(5 - 1 downto 0);
        wrireReg3      :in std_logic_vector(5 - 1 downto 0);
        writeRegValue1 :in std_logic_vector(XLEN - 1 downto 0);
        writeRegValue2 :in std_logic_vector(XLEN - 1 downto 0);
        writeRegValue3 :in std_logic_vector(XLEN - 1 downto 0);
        readReg1       :out std_logic_vector(XLEN - 1 downto 0);
        readReg2       :out std_logic_vector(XLEN - 1 downto 0);
        readReg3       :out std_logic_vector(XLEN - 1 downto 0);
        readReg4       :out std_logic_vector(XLEN - 1 downto 0);
        readReg5       :out std_logic_vector(XLEN - 1 downto 0);
        readReg6       :out std_logic_vector(XLEN - 1 downto 0)
    );
end reg_file;

architecture BEHAVIOUR of reg_file is
type RAM is array (XLEN / 2 - 1 downto 0) of std_logic_vector(XLEN - 1 downto 0);
signal reg : ram;

begin
write_reg: process(clk)
variable i : integer range 0 to XLEN          ;

begin    
    if rising_edge(clk) then
        if(sresetn = '0') then
            for i in 0 to ((XLEN/2) - 1) loop
                reg(i) <= (others => '0');
            end loop;                                 
        elsif writeEanble = '1' then 
            reg(to_integer(unsigned(writeReg1))) <= writeRegValue1;
            reg(to_integer(unsigned(writeReg2))) <= writeRegValue2;
            reg(to_integer(unsigned(wrireReg3))) <= writeRegValue3;
        end if;
    end if;
end process write_reg;

read_reg: process(reg1, reg2, reg3, reg4, reg5, reg6)
begin
    if(to_integer(unsigned(reg1)) = 0) then
        readReg1 <= (XLEN - 1 downto 0 => '0');
    else
        readReg1 <= reg(to_integer(unsigned(reg1)));
    end if;
    if to_integer(unsigned(reg2)) = 0 then
        readReg2 <= (XLEN - 1 downto 0 => '0');
    else
        readReg2 <=  reg(to_integer(unsigned(reg2)));
    end if;
    if(to_integer(unsigned(reg3)) = 0) then
        readReg3 <= (XLEN - 1 downto 0 => '0');
    else
        readReg3 <= reg(to_integer(unsigned(reg3)));
    end if;
    if(to_integer(unsigned(reg4)) = 0) then
        readReg4 <= (XLEN - 1 downto 0 => '0');
    else
        readReg4 <= reg(to_integer(unsigned(reg4)));
    end if;
    if(to_integer(unsigned(reg5)) = 0) then
        readReg5 <= (XLEN - 1 downto 0 => '0');
    else
        readReg5 <= reg(to_integer(unsigned(reg5)));
    end if;
    if(to_integer(unsigned(reg6)) = 0) then
        readReg6 <= (XLEN - 1 downto 0 => '0');
    else
        readReg6 <= reg(to_integer(unsigned(reg6)));
    end if;

end process read_reg;

end BEHAVIOUR;
