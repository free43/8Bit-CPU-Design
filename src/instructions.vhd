library ieee;
use ieee.std_logic_1164.all;

package INSTRUCTIONS is
    --LOAD and STORE Instructions--
    constant LDA_IMM : std_logic_vector(7 downto 0) := x"00"; -- LDA_IMM <value>: A = value --
    constant LDA_DIR : std_logic_vector(7 downto 0) := x"01"; -- LDA_DIR <address>: A = mem[address]--
    constant LDB_IMM : std_logic_vector(7 downto 0) := x"02"; -- LDB_IMM <value>: B = value --
    constant LDB_DIR : std_logic_vector(7 downto 0) := x"03"; -- LDB_DIR <address>: B = mem[address]--
    constant STA_DIR : std_logic_vector(7 downto 0) := x"04"; -- STA_DIR <address>: mem[address] = A --
    constant STB_DIR : std_logic_vector(7 downto 0) := x"05"; -- STB_DIR <address>: mem[address] = B --
    --Arithmetic and Logic--
    constant ADD_AB : std_logic_vector(7 downto 0) := x"55"; --ADD_AB: A = A + B--
    constant SUB_AB : std_logic_vector(7 downto 0) := x"56"; --SUB_AB: A = A - B--
    constant AND_AB : std_logic_vector(7 downto 0) := x"57"; --AND_AB: A = A & B--
    constant OR_AB : std_logic_vector(7 downto 0) := x"58"; -- OR_AB: A = A | B--     
    constant INC_A : std_logic_vector(7 downto 0) := x"59"; -- INC_A: A = A + 1--
    constant INC_B : std_logic_vector(7 downto 0) := x"5A"; -- INC_B: B = B + 1-- 
    constant DEC_A : std_logic_vector(7 downto 0) := x"5B"; -- DEC_A: A = A - 1--
    constant DEC_B : std_logic_vector(7 downto 0) := x"5C"; -- DEC_B: B = B - 1--
    --Branches--
    constant JMP : std_logic_vector(7 downto 0) := x"AA"; --JMP <address> jumps to address--
    constant JMP_IN : std_logic_vector(7 downto 0) := x"AB"; --JMP_IN <address> jumps to address, if negativ flag is set (N=1)--
    constant JMP_NN : std_logic_vector(7 downto 0) := x"AC"; --JMP_NN <address> jumps to address, if negativ flag isn't set (N=0)--
    constant JMP_IZ : std_logic_vector(7 downto 0) := x"AD"; --JMP_IZ <address> jumps to address, if zero flag is set (Z=1)--
    constant JMP_NZ : std_logic_vector(7 downto 0) := x"AE"; --JMP_NZ <address> jumps to address, if zero flag isn't set (Z=0)--
    constant JMP_IC : std_logic_vector(7 downto 0) := x"AF"; --JMP_IC <address> jumps to address, if carry flag is set (C=1)--
    constant JMP_NC : std_logic_vector(7 downto 0) := x"B0"; --JMP_NC <address> jumps to address, if carry is'nt carry set (C=0)--
end INSTRUCTIONS;