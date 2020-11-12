
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY mul IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        clk, rst : IN STD_LOGIC;
        start_puls : IN STD_LOGIC;
        done_puls : OUT STD_LOGIC;
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END mul;

ARCHITECTURE arch OF mul IS
    SIGNAL counter, counter_last : STD_LOGIC_VECTOR(1 DOWNTO 0);
    -- SIGNAL integrator, integrator2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN

    -- combinatorical logic
    PROCESS (counter)
        VARIABLE number1 : unsigned(7 DOWNTO 0) := x"00";
        VARIABLE number2 : unsigned(1 DOWNTO 0) := "00";
        VARIABLE result : unsigned(9 DOWNTO 0) := "00" & x"00";
        VARIABLE int1, int2, int3, int4 : unsigned(15 DOWNTO 0) := x"0000";
    BEGIN

        number1 := unsigned(a);
        number2 := unsigned(shift_right(unsigned(b), TO_INTEGER(unsigned(counter)) * 2)(1 DOWNTO 0));
        result := number1 * number2;

        Q <= x"0000";

        IF counter = "00" THEN
            int1 := "000000" & result;
            Q <= STD_LOGIC_VECTOR(int1(15 DOWNTO 0));
            done_puls <= '0';
        ELSIF counter = "01" THEN
            int2 := int1 + shift_left(result, 2);
            Q <= STD_LOGIC_VECTOR(int2(15 DOWNTO 0));
            done_puls <= '0';
        ELSIF counter = "10" THEN
            int3 := int2 + shift_left(result, 4);
            Q <= STD_LOGIC_VECTOR(int3(15 DOWNTO 0));
            done_puls <= '0';
        ELSIF counter = "11" THEN
            int4 := int3 + shift_left(result, 6);
            Q <= STD_LOGIC_VECTOR(int4(15 DOWNTO 0));
            done_puls <= '1';
        END IF;

    END PROCESS;

    PROCESS (clk, rst)
    BEGIN

        IF rst = '1' THEN
            counter <= "00";
        ELSIF rising_edge(clk) THEN
            counter_last <= counter;
            counter <= counter + 1;

            IF start_puls = '1' THEN
                counter <= "00";
            END IF;
        END IF;

    END PROCESS;

END arch;