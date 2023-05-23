library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_cmds.all;
entity alu is
  port (
    a, b : in std_logic_vector(7 downto 0);
    alu_out : out std_logic_vector(7 downto 0);
    alu_sel : in std_logic_vector(3 downto 0);
    zero, carry, negativ : out std_logic
  ) ;
end alu;


architecture bh of alu is

          

begin
    process(a, b, alu_sel)
    variable res : unsigned(8 downto 0) := to_unsigned(0, 9);
    constant one : unsigned(8 downto 0) := (0 => '1', others => '0');
    begin
        case( alu_sel ) is
        
            when ADD_CMD =>    --Add: a + b--
                            res :=  unsigned('0' & a) + unsigned( '0' & b);
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when SUB_CMD =>    --Sub: a - b--
                            res :=  unsigned('0' & a) - unsigned( '0' & b);
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when AND_CMD =>    --&: a & b --
                            res :=  unsigned('0' & (a and b));
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when OR_CMD =>    --|: a | b --
                            res :=  unsigned('0' & (a or b));
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when INC_A_CMD =>    --a++: a + 1 --
                            res :=  unsigned('0' & a) + one;
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when INC_B_CMD =>    --b++: b + 1 --
                            res :=  unsigned('0' & b) + one;
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when DEC_A_CMD =>    -- a--: a - 1 --
                            res :=  unsigned('0' & a) - one;
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when DEC_B_CMD =>    -- b--: b - 1 --
                            res :=  unsigned('0' & b) - one;
                            alu_out <= std_logic_vector(res(7 downto 0));
                            negativ <= res(7);
                            if (res(7 downto 0) = x"00") then
                                zero <= '1';
                            else
                                zero <= '0';
                            end if;
                            carry <= res(8);
            when others =>  zero <= '0';
                            carry <= '0';
                            negativ <= '0';
                            alu_out <= (others => '0');
        end case ;
    end process;

end bh ; -- bh