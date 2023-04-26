library ieee;
use ieee.std_logic_1164.all;

package INSTRUCTIONS is
    --LOAD and STORE Instructions--
    constant LDA_IMM : std_logic_vector(7 downto 0) := x"0F";
    constant LDA_MEM : std_logic_vector(7 downto 0) := x"23";
    constant LDB_IMM : std_logic_vector(7 downto 0) := x"24";
    constant LDB_MEM : std_logic_vector(7 downto 0) := x"20";
    constant STA : std_logic_vector(7 downto 0) := x"25";
    constant STB : std_logic_vector(7 downto 0) := x"21";
    --Arithmetic and Logic--
    constant ADDAB : std_logic_vector(7 downto 0) := x"00";
    constant SUBAB : std_logic_vector(7 downto 0) := x"08";
    constant ANDAB : std_logic_vector(7 downto 0) := x"09";
    constant ORAB : std_logic_vector(7 downto 0) := x"0A";
    --Branches--
    constant J_IMM : std_logic_vector(7 downto 0) := x"12";
    constant BEQZ : std_logic_vector(7 downto 0) := x"04";
    constant BNEZ : std_logic_vector(7 downto 0) := x"05";
    

end INSTRUCTIONS;