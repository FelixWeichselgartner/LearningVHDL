library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity Sequenzdetektor is
  port (clock,a_rst  : in std_logic;
        x            : in std_logic;
        y_q          : out std_logic );
end Sequenzdetektor;
------------------------------------
architecture Mealy of Sequenzdetektor is
type states is (z0, z1, z2);
signal z_q, z_next : states;
signal xh_q, x_q, y   : std_logic;
begin

  -- sequential logic
  process(clock, a_rst)
  begin
    if a_rst = '1' then             -- asynchroner Reset
      z_q  <= z0;                   -- alle FFs rücksetzen
      y_q  <= '0';
      x_q  <= '1';
      xh_q <= '1';
    elsif rising_edge(clock) then   -- steigende Taktflanke
      xh_q <= x;                    -- asynchrones Eingangssignal
      x_q  <= xh_q;                 -- zweimal abtakten
      y_q <= y;
      z_q <= z_next;
      
    end if;
  end process;
  
  -- combinatoric logic
  process(x_q, z_q)
  begin
    y  <= '0';                  -- y_q auf Defaultwert setzen
    case z_q is
        when z0 => if x_q = '0' then     -- wechsle auf z1
                     z_next <= z1;
                   end if;
        when z1 => if x_q = '1' then     -- wechsle auf z2 
                     z_next <= z2;
                   end if;
        when z2 => if x_q = '0' then     -- wechsle auf z1 
                     z_next <= z1;
                     y <= '1';         -- Folge erkannt!!
                   else                  -- wechsle auf z0
                     z_next <= z0;
                   end if;
        when others => z_next <= z0;        -- wechsle auf z0
      end case;
  end process;
end Mealy;
