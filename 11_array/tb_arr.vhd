----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 20.10.2020
-- Design Name:
-- Module Name:
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_arr IS
    --  Port ( );
END tb_arr;

ARCHITECTURE Behavioral OF tb_arr IS

    CONSTANT T : TIME := 10 ns; -- clock period

    SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL a0, a1 : STD_LOGIC;
    SIGNAL d0, d1, d2, d3, d4, d5, d6, d7 : STD_LOGIC;

    COMPONENT arr IS
        PORT (
            a0, a1 : IN STD_LOGIC;
            d0, d1, d2, d3, d4, d5, d6, d7 : OUT STD_LOGIC);
    END COMPONENT;

BEGIN

    dut : arr
    PORT MAP(
        a0 => a0, a1 => a1,
        d0 => d0, d1 => d1, d2 => d2, d3 => d3, d4 => d4, d5 => d5, d6 => d6, d7 => d7
    );

    -- test procedure
    PROCESS
    BEGIN

        --"01100011", "11010110", "10010111", "11101011" 
        a0 <= '0';
        a1 <= '0';
        WAIT FOR 1ns;
        data <= d7 & d6 & d5 & d4 & d3 & d2 & d1 & d0;
        WAIT FOR T;

        ASSERT data = "01100011"
        REPORT "data is not correct."
            SEVERITY FAILURE;

        a0 <= '1';
        a1 <= '0';
        WAIT FOR 1ns;
        data <= d7 & d6 & d5 & d4 & d3 & d2 & d1 & d0;
        WAIT FOR T;

        ASSERT data = "11010110"
        REPORT "data is not correct."
            SEVERITY FAILURE;

        a0 <= '0';
        a1 <= '1';
        WAIT FOR 1ns;
        data <= d7 & d6 & d5 & d4 & d3 & d2 & d1 & d0;
        WAIT FOR T;

        ASSERT data = "10010111"
        REPORT "data is not correct."
            SEVERITY FAILURE;

        a0 <= '1';
        a1 <= '1';
        WAIT FOR 1ns;
        data <= d7 & d6 & d5 & d4 & d3 & d2 & d1 & d0;
        WAIT FOR T;

        ASSERT data = "11101011"
        REPORT "data is not correct."
            SEVERITY FAILURE;

        WAIT;
    END PROCESS;

END Behavioral;