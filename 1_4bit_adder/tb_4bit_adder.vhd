----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 15.10.2020
-- Design Name:
-- Module Name: tb_4bit_adder - Behavioral
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

ENTITY tb_adder IS
    --  Port ( );
END tb_adder;

ARCHITECTURE Behavioral OF tb_adder IS

    CONSTANT T : TIME := 1 ns; -- clock period

    SIGNAL a, b, q : std_logic_vector(3 DOWNTO 0);
    SIGNAL sum : std_logic_vector(4 DOWNTO 0);
    SIGNAL c : std_logic;

    COMPONENT adder IS
        PORT (
            a : IN std_logic_vector(3 DOWNTO 0);
            b : IN std_logic_vector(3 DOWNTO 0);
            Q : OUT std_logic_vector(3 DOWNTO 0);
            c : OUT std_logic);
    END COMPONENT;

BEGIN

    dut : adder
    PORT MAP(
        a => a, b => b, q => q, c => c
    );

    -- test procedure
    PROCESS
        VARIABLE i, l : unsigned(3 DOWNTO 0);
    BEGIN
        FOR i IN 0 TO 15 LOOP
            FOR l IN 0 TO 15 LOOP
                a <= std_logic_vector(TO_UNSIGNED(i, 4));
                b <= std_logic_vector(TO_UNSIGNED(l, 4));
                sum <= ('0' & std_logic_vector(TO_UNSIGNED(i, 4)))
                    + ('0' & std_logic_vector(TO_UNSIGNED(l, 4)));
                WAIT FOR T;

                -- convert integer (i) to 1. to Unsigned 
                --                        2. to std_logic_vector
                ASSERT (q = (sum(3) & sum(2) & sum(1) & sum(0))) OR (c = sum(4))
                REPORT "adder or carry value is not correct."

                    SEVERITY FAILURE;
            END LOOP;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;