
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY mul IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END mul;

ARCHITECTURE arch OF mul IS
BEGIN

    -- combinatorical logic
    PROCESS (a, b)
        VARIABLE number1, number2 : unsigned(7 DOWNTO 0) := x"00";
        VARIABLE result : unsigned(15 DOWNTO 0) := x"0000";
    BEGIN
        -- default values
        Q <= x"0000";

        number1 := unsigned(a);
        number2 := unsigned(b);
        result := number1 * number2;

        Q <= STD_LOGIC_VECTOR(result(15 DOWNTO 0));
    END PROCESS;

END arch;