-------------------------------------------------------------------------------
-- File Name: tb_simple.vhdl
-- Program Description: Test Bench for Moore Machine Example
-- Reference: Lee, S. (2011). Introduction to VHDL. Singapore: Cengage
-- Learning Asia Pte Ltd
-------------------------------------------------------------------------------

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.STATE_CONSTANTS.all;

-- Entity Definition
entity tb_simple is
	constant PERIOD1: time := 100 ns; -- clock period
end entity tb_simple;

architecture tb_simple of tb_simple is
	signal z: std_logic;	-- data output from the state machine
	signal state: std_logic_vector(STATE_BITS-1 downto 0);
							-- the current state	
	signal reset_n: std_logic; -- active-low reset signal
	signal clk: std_logic := '0'; -- clock signal (init. to 0)
	signal x: std_logic;	-- input data for the state machine		
	
	-- Component declaration
	component simple is
		 port (z: out std_logic; -- data output
	 	 state: out std_logic_vector(STATE_BITS-1 downto 0);
							-- current state of state machine
		 reset_n: in std_logic; -- active-low reset signal
	 	 clk: in std_logic; -- clock signal
	 	 x: in std_logic); -- the signal data input			  				
	end component simple;

	-- Error checking and reporting procedure
	procedure check_state_z
		(expected_state: std_logic_vector(STATE_BITS-1 downto 0);
		expected_z: std_logic;
		actual_state: std_logic_vector(STATE_BITS-1 downto 0);
		actual_z: std_logic;
		error_count: inout integer) is
	begin
		-- check if expected_state is the same as actual_state
		assert(expected_state = actual_state)
			report "ERROR: Expected state (" &
				std_logic'image(expected_state(1)) &
				std_logic'image(expected_state(0)) & ") /= actual (" &
				std_logic'image(actual_state(1)) &
				std_logic'image(actual_state(0)) &
				") at time " & time'image(now);

			-- increment error_count (state)
			if(expected_state/=actual_state) then
				error_count := error_count + 1;
			end if;

			-- increment error_count (z)
			if(expected_z/=actual_z) then
				report "ERROR: Expected output z (" &
					std_logic'image(expected_z) & ") /= actual (" &
					std_logic'image(actual_z) &
					") at time " & time'image(now);
				error_count := error_count + 1;
			end if;	-- of if (expected_z /= acutal check z)
	end procedure check_state_z;

begin	-- begin main body of the simple architecture
	-- instantiate the unit under test
	simple1: component simple port map(z,state,reset_n,clk,x);

	-- generate a LOW pulse for reset_n
	reset_n <= '1', '0' after (PERIOD1 / 4),
			   '1' after (PERIOD1 + PERIOD1/4);

	-- generate an input clock with a period of PERIOD1
	-- negate the clock
	-- note: assume clk has been initialized to '0' above
	clock: clk <= not clk after (PERIOD1/2);

	-- main process: generate test vectors and check results
	main: process is
		variable error_count: integer := 0; -- number of simulation errors
	begin
		report "Start simulation.";
		x <= '0';		-- initial data value
		wait for PERIOD1;
		check_state_z(S0,'0', state, z, error_count); -- start at S0
		wait for PERIOD1;
		check_state_z(S2,'1', state, z, error_count); -- go to S2
		x <= '1';
		wait for PERIOD1;
		check_state_z(S0,'0', state, z, error_count); -- go to S0
		wait for PERIOD1;
		check_state_z(S1,'0', state, z, error_count); -- go to S1
		wait for PERIOD1;
		check_state_z(S1,'0', state, z, error_count); -- stay in S1
		x <= '0';
		wait for PERIOD1;
		check_state_z(S2,'1', state, z, error_count); -- go to S2
		wait for PERIOD1;
		check_state_z(S0,'0', state, z, error_count); -- go to S0
		wait for PERIOD1;
		
		-- check if there are errors
		if(error_count=0) then
			report "Simulation completed with NO errors.";
		else
			report "ERROR: There were " &
					integer'image(error_count) & " errors.";
		end if;

		wait;		-- halt this process (note: simulation
	end process main; -- continues due to clk assignment statement)
end architecture tb_simple;

