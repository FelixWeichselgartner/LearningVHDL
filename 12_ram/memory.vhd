LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
--USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY memory IS
    -- all ports of type std_logic / std_logic_vector
    port (clk      : in std_logic;
          enable   : in std_logic; -- access memory
          write    : in std_logic; -- '1': write, '0' : read;
          address  : in std_logic_vector(1 downto 0);
          data_in  : in std_logic_vector(7 downto 0);
          data_out : out std_logic_vector(7 downto 0));
END memory;

ARCHITECTURE arch OF memory IS
    TYPE feld_type IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL mem : feld_type := (
        --"01100011", "11010110", "10010111", "11101011" 
        x"63", x"D6", x"97", x"EB"
    );
BEGIN

    -- combinatorical logic
    PROCESS (clk)
    BEGIN
        if rising_edge(clk) and enable = '1' then
            if write = '0' then
                -- read data
                data_out <= mem(to_integer(unsigned(address)));
            else
                -- write data
                mem(to_integer(unsigned(address))) <= data_in;
            end if;
        end if;

    END PROCESS;

END arch;
