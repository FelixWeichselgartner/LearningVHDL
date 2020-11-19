
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY Multiplizierer_C IS
    -- all ports of type std_logic / std_logic_vector
    port (clk, rst       : in std_logic;
          a, b           : in std_logic_vector(7 downto 0);
          data_valid_in  : in std_logic; -- shift data_valid_in into data_valid_out
          data_valid_out : out std_logic;
          c              : out std_logic_vector(15 downto 0));
END Multiplizierer_C;

ARCHITECTURE arch OF Multiplizierer_C IS
    TYPE input_field IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE output_field IS ARRAY (0 TO 2) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    TYPE flag_field IS ARRAY (0 TO 3) OF STD_LOGIC;
    SIGNAL f_field : flag_field := ('0', '0', '0', '0'); 
    SIGNAL a_field, b_field : input_field := (x"00", x"00", x"00", x"00");
    SIGNAL c_field : output_field := (x"0000", x"0000", x"0000");
BEGIN

    -- combinatorical logic
    PROCESS (clk, rst, data_valid_in, a, b)
        VARIABLE number1 : unsigned(7 DOWNTO 0) := x"00";
        VARIABLE number2 : unsigned(1 DOWNTO 0) := "00";
        VARIABLE result : unsigned(9 DOWNTO 0) := "00" & x"00";
    BEGIN
        if rst = '1' then
            for i in 1 to 3 loop
                a_field(i) <= x"00";
                b_field(i) <= x"00";
                f_field(i) <= '0';
            end loop;
            
            for i in 1 to 2 loop
                c_field(i) <= x"0000";
            end loop;
        
        
        elsif rising_edge (clk) then
            
            f_field(0) <= data_valid_in;
            for i in 1 to 3 loop
                f_field(i) <= f_field(i - 1);
            end loop;
            data_valid_out <= f_field(3);
            
            a_field(0) <= a;
            b_field(0) <= b;
            for i in 1 to 3 loop
                a_field(i) <= a_field(i - 1);
                b_field(i) <= b_field(i - 1);
            end loop;
            
            for i in 0 to 3 loop
                number1 := unsigned(a_field(i));
                number2 := unsigned(shift_right(unsigned(b_field(i)), i * 2)(1 DOWNTO 0));
                result := number1 * number2;
                if i = 3 then
                    c <= std_logic_vector(shift_left("000000" & result, i * 2)) + c_field(i - 1);
                elsif i > 0 and not (i = 3) then
                    c_field(i) <= std_logic_vector(shift_left("000000" & result, i * 2)) + c_field(i - 1);
                else 
                    c_field(i) <= "000000" & std_logic_vector(result);
                end if;
            end loop;
            
        end if;

    END PROCESS;

END arch;