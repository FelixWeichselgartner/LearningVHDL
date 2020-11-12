-- based on: https://github.com/FelixWeichselgartner/FPGA_GameBoy_Cartridge

LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
--USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY arr IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        a0, a1 : IN STD_LOGIC;
        d0, d1, d2, d3, d4, d5, d6, d7 : OUT STD_LOGIC);
END arr;

ARCHITECTURE arch OF arr IS
    TYPE feld_type IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT my_array : feld_type := (
        --"01100011", "11010110", "10010111", "11101011" 
        x"63", x"D6", x"97", x"EB"
    );
BEGIN

    -- combinatorical logic
    PROCESS (a1, a0)
        VARIABLE address : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        address := a1 & a0;
        data := my_array(to_integer(unsigned(address)));

        d7 <= data(7);
        d6 <= data(6);
        d5 <= data(5);
        d4 <= data(4);
        d3 <= data(3);
        d2 <= data(2);
        d1 <= data(1);
        d0 <= data(0);

    END PROCESS;

END arch;