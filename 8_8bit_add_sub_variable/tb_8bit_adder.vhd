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

    SIGNAL a, b, q : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL c : STD_LOGIC;
    SIGNAL m, s, zero : STD_LOGIC;

    COMPONENT adder IS
        PORT (
            a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            m : IN STD_LOGIC; -- mode 1: add; mode 0: subtract
            Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            c : OUT STD_LOGIC; -- carry of result
            s : OUT STD_LOGIC; -- if 1 result is negative
            zero : OUT STD_LOGIC); -- if 1 result is zero);
    END COMPONENT;

BEGIN

    dut : adder
    PORT MAP(
        a => a, b => b, q => Q, c => c,
        m => m, s => s, zero => zero
    );

    -- test procedure
    PROCESS
        VARIABLE i, l : unsigned(7 DOWNTO 0);
    BEGIN
        m <= '1';
        a <= x"00";
        b <= x"00";

        FOR i IN 0 TO 12 LOOP
            FOR l IN 0 TO 24 LOOP
                a <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8));
                b <= STD_LOGIC_VECTOR(TO_UNSIGNED(l, 8));
                sum <= ('0' & STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8)))
                    + ('0' & STD_LOGIC_VECTOR(TO_UNSIGNED(l, 8)));
                WAIT FOR T;

                -- convert integer (i) to 1. to Unsigned 
                --                        2. to std_logic_vector
                ASSERT (q = (sum(7) & sum(6) & sum(5) & sum(4) & sum(3) & sum(2) & sum(1) & sum(0))) OR (c = sum(8))
                REPORT "adder or carry value is not correct."
                    SEVERITY FAILURE;
            END LOOP;
        END LOOP;

        m <= '0';
        a <= x"00";
        b <= x"00";

        FOR i IN 0 TO 12 LOOP
            FOR l IN 0 TO 24 LOOP
                a <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8));
                b <= STD_LOGIC_VECTOR(TO_UNSIGNED(l, 8));
                sum <= ('0' & STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8)))
                    - ('0' & STD_LOGIC_VECTOR(TO_UNSIGNED(l, 8)));
                WAIT FOR T;

                -- convert integer (i) to 1. to Unsigned 
                --                        2. to std_logic_vector
                ASSERT (q = (sum(7) & sum(6) & sum(5) & sum(4) & sum(3) & sum(2) & sum(1) & sum(0))) OR (c = sum(8))
                REPORT "adder or carry value is not correct."
                    SEVERITY FAILURE;
            END LOOP;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;