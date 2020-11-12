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

ENTITY tb_mul IS
    --  Port ( );
END tb_mul;

ARCHITECTURE Behavioral OF tb_mul IS

    CONSTANT T : TIME := 1 ns; -- clock period

    SIGNAL a, b : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL q : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR(15 DOWNTO 0);

    COMPONENT mul IS
        PORT (
            a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); -- if 1 result is zero);
    END COMPONENT;

BEGIN

    dut : mul
    PORT MAP(
        a => a, b => b, q => Q
    );

    -- test procedure
    PROCESS
        VARIABLE i, l : unsigned(7 DOWNTO 0);
    BEGIN
        a <= x"00";
        b <= x"00";

        FOR i IN 0 TO 12 LOOP
            FOR l IN 0 TO 24 LOOP
                a <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8));
                b <= STD_LOGIC_VECTOR(TO_UNSIGNED(l, 8));
                sum <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8) * TO_UNSIGNED(l, 8));
                WAIT FOR T;

                -- convert integer (i) to 1. to Unsigned 
                --                        2. to std_logic_vector
                ASSERT (q = sum)
                REPORT "adder or carry value is not correct."
                    SEVERITY FAILURE;
            END LOOP;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;