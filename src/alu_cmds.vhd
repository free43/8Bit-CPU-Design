library ieee;
use ieee.std_logic_1164.all;

package ALU_CMDS is
    constant ADD_CMD : std_logic_vector(3 downto 0) := x"0"; -- a + b --
    constant SUB_CMD : std_logic_vector(3 downto 0) := x"1"; -- a - b --
    constant AND_CMD : std_logic_vector(3 downto 0) := x"2"; -- a & b --
    constant OR_CMD : std_logic_vector(3 downto 0) := x"3"; -- a | b --
    constant INC_A_CMD : std_logic_vector(3 downto 0) := x"4"; -- a++ --
    constant INC_B_CMD : std_logic_vector(3 downto 0) := x"5"; -- b++ --
    constant DEC_A_CMD : std_logic_vector(3 downto 0) := x"6"; -- a-- --
    constant DEC_B_CMD : std_logic_vector(3 downto 0) := x"7"; -- b-- --
    constant NO_OP_CMD : std_logic_vector(3 downto 0) := x"F"; -- No operation done -- 
end ALU_CMDS;