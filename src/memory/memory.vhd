library ieee;
use ieee.std_logic_1164.all;

entity memory is
  port (
    clk, reset, write_enable : in std_logic;
    address, data_in : in std_logic_vector(7 downto 0);
    port_in0 : in std_logic_vector(7 downto 0);
    port_in1 : in std_logic_vector(7 downto 0);
    port_in2 : in std_logic_vector(7 downto 0);
    port_in3 : in std_logic_vector(7 downto 0);
    port_in4 : in std_logic_vector(7 downto 0);
    port_in5 : in std_logic_vector(7 downto 0);
    port_in6 : in std_logic_vector(7 downto 0);
    port_in7 : in std_logic_vector(7 downto 0);
    port_out0 : out std_logic_vector(7 downto 0);
    port_out1 : out std_logic_vector(7 downto 0);
    port_out2 : out std_logic_vector(7 downto 0);
    port_out3 : out std_logic_vector(7 downto 0);
    port_out4 : out std_logic_vector(7 downto 0);
    port_out5 : out std_logic_vector(7 downto 0);
    port_out6 : out std_logic_vector(7 downto 0);
    port_out7 : out std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0)
    );
    end memory;
    
    architecture bh of memory is
      
      signal data_rom, data_rw : std_logic_vector(7 downto 0) := x"00";
  component rom_memory
    port(
        clk : in std_logic;
        address : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
  end component; 

  component rw_memory
    port(
        clk, write_enable : in std_logic;
        address, data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
  end component;

  component out_ports
    port(
        clk, reset, write_enable : in std_logic;
        address, data_in : in std_logic_vector(7 downto 0);
        port_out0 : out std_logic_vector(7 downto 0);
        port_out1 : out std_logic_vector(7 downto 0);
        port_out2 : out std_logic_vector(7 downto 0);
        port_out3 : out std_logic_vector(7 downto 0);
        port_out4 : out std_logic_vector(7 downto 0);
        port_out5 : out std_logic_vector(7 downto 0);
        port_out6 : out std_logic_vector(7 downto 0);
        port_out7 : out std_logic_vector(7 downto 0)
    );
  end component;

  component out_mux
    port(
        address, data_rom, data_rw : in std_logic_vector(7 downto 0);
        port_in0 : in std_logic_vector(7 downto 0);
        port_in1 : in std_logic_vector(7 downto 0);
        port_in2 : in std_logic_vector(7 downto 0);
        port_in3 : in std_logic_vector(7 downto 0);
        port_in4 : in std_logic_vector(7 downto 0);
        port_in5 : in std_logic_vector(7 downto 0);
        port_in6 : in std_logic_vector(7 downto 0);
        port_in7 : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
  end component;
begin
  rom:rom_memory port map(clk => clk, address => address, data_out => data_rom);
  rw:rw_memory port map(clk => clk, write_enable => write_enable, address => address, data_in => data_in, data_out => data_rw);
  op:out_ports port map(clk => clk, reset => reset, write_enable => write_enable, address => address, data_in => data_in, 
                        port_out0 => port_out0,
                        port_out1 => port_out1,  
                        port_out2 => port_out2,
                        port_out3 => port_out3,  
                        port_out4 => port_out4,
                        port_out5 => port_out5,  
                        port_out6 => port_out6,  
                        port_out7 => port_out7  
                      );
  om: out_mux port map(address => address, data_rom => data_rom, data_rw => data_rw,
                        port_in0 => port_in0, 
                        port_in1 => port_in1,
                        port_in2 => port_in2, 
                        port_in3 => port_in3, 
                        port_in4 => port_in4, 
                        port_in5 => port_in5, 
                        port_in6 => port_in6, 
                        port_in7 => port_in7,
                        data_out => data_out 
                      );

end bh ; -- bh