-------------------------------------------------------------------------------
-- File Name: simple.vhdl
-- Program Description: Moore Machine Example
-- It implements a simple state machine. This machine transitions among
-- three states depending on the value of the input variable x. Output z
-- is et to 1 in state s2 and 0 in all other states. The state machine
-- is a Moore machine.
-- Reference: Lee, S. (2011). Introduction to VHDL. Singapore: Cengage
-- Learning Asia Pte Ltd
-------------------------------------------------------------------------------

-- Package Definition for Global Constants
library IEEE; use IEEE.std_logic_1164.all;
package STATE_CONSTANTS is
	constant STATE_BITS: integer := 2; -- number of bits in state
	constant S0: std_logic_vector(1 downto 0) := "00"; -- states
	constant S1: std_logic_vector(1 downto 0) := "01";
	constant S2: std_logic_vector(1 downto 0) := "11";
end package;
-------------------------------------------------------------------------------

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use work.STATE_CONSTANTS.all;

-- Entity Definition
entity simple is
	port (z: out std_logic; -- data output
	 state: out std_logic_vector(STATE_BITS-1 downto 0);
							-- current state of state machine
	 reset_n: in std_logic; -- active-low reset signal
	 clk: in std_logic; -- clock signal
	 x: in std_logic); -- the signal data input		  			
end entity simple;

architecture simple of simple is
	signal internal_state: std_logic_vector(STATE_BITS-1 downto 0);

begin
	state <= internal_state; -- used to show internal state value
	
	form_output: process(internal_state) is
	begin
		case internal_state is
			when S0 =>
					z <= '0';
			when S1 =>
					z <= '0';
			when S2 =>
					z <= '1';
			when others =>
					z <= 'X'; -- included for completeness
		end case;
	end process form_output;
	
	next_state: process(reset_n, clk) is
	begin
		if(reset_n = '0') then		-- asynchronous reset
			internal_state <= S0;
		elsif rising_edge(clk) then	-- on positive clock edge
			case internal_state is
				when S0 =>			-- case S0
					if(x='1') then
						internal_state <= S1;
					else
						internal_state <= S2;
					end if;
				when S1 =>			-- case S1
					if(x/='1') then
						internal_state <= S2;
					end if;
				when S2 => internal_state <= S0; --  case S2
				when others => internal_state <= "XX";
			end case; -- "when others" is included for completeness
		end if;
	end process next_state;
end architecture simple;

