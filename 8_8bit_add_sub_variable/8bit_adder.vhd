
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY adder IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        m : IN STD_LOGIC; -- mode 1: add; mode 0: subtract
        Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        c : OUT STD_LOGIC; -- carry of result
        s : OUT STD_LOGIC; -- if 1 result is negative
        zero : OUT STD_LOGIC); -- if 1 result is zero
END adder;

ARCHITECTURE arch OF adder IS
BEGIN

    -- combinatorical logic
    PROCESS (a, b, m)
        VARIABLE number1, number2 : signed(7 DOWNTO 0);
        VARIABLE result : signed(8 DOWNTO 0) := "000000000";
    BEGIN
        -- default values
        Q <= x"00";
        c <= '0';
        s <= '0';
        zero <= '0';

        number1 := signed(a);
        number2 := signed(b);

        -- subtraction
        IF (m = '0') THEN
            number2 := - number2;
            
            -- number is positive
            IF number2(7) = 0 then
            end if;
        END IF;

        -- addition
        result := (number1(7) & number1) + (number2(7) & number2);
        
        -- overflow
        
        
        -- signed
        s <= result(8);

        -- zero
        IF result(7 DOWNTO 0) = x"00" THEN
            zero <= '1';
        END IF;

        Q <= STD_LOGIC_VECTOR(result(7 DOWNTO 0));
    END PROCESS;

END arch;